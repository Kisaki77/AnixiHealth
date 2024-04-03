import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:health_anixi/APIs/OzowApi.dart';
import 'package:http/http.dart' as http;

class PaymentScreenState with ChangeNotifier{
  double? amount;
  String? reference;
  String postPaymentUrl = "https://uct.ac.za/";
  String? paymentStatusResponse;
  String? bankName;
  String? transactionId;
  String? uid;
  String? createdDate;
  String? paymentDate;
  String? subStatus;
  String? statusMessage;
  String? currencyCode;

  PaymentScreenState({required this.amount,required this.reference,required this.uid}) {
    paymentStatus().then((value) {
      paymentStatusResponse = value;
      notifyListeners();
    });
  }

  //Notify URL

  // This is the function that produces the hash check in order to verify the transaction
  String hashCheck({
    required String SiteCode,
    required String CountryCode,
    required String CurrencyCode,
    required String Amount,
    required String TransactionReference,
    required String BankReference,
    // add in optional field: Notify URL
    required String IsTest
  }){
    String hash = "$SiteCode$CountryCode$CurrencyCode$Amount$TransactionReference${BankReference}${IsTest}79e8b55d86f44811bc5428e84155b127";
    hash = hash.toLowerCase();
    var bytes = utf8.encode(hash); // data being hashed
    var hashEncrypted = sha512.convert(bytes);
    return hashEncrypted.toString();
  }



  dynamic postPayment()async{
    // This is where we send the payment details to the Ozow server

    Map<String,dynamic> hash = {
      "SiteCode":OzowApi().SiteCode ,//Site Code
      "CountryCode":"ZA", // Country code
      "CurrencyCode":"ZAR", // Currency Code
      "Amount":amount!.toStringAsFixed(2) ,// Amount
      "TransactionReference":reference, //transactionReference (our reference - need to make this unique)
      "BankReference":OzowApi().BankReference, // What customer will see on their bank statement
      "IsTest":false, // isTest
      "HashCheck":hashCheck(
          SiteCode: OzowApi().SiteCode,
          CountryCode: "ZA",
          CurrencyCode: "ZAR",
          Amount: amount!.toStringAsFixed(2),
          TransactionReference: reference!,
          BankReference: OzowApi().BankReference,
          IsTest: "false")
    };

    var resp = await http.post(Uri.parse('https://api.ozow.com/postpaymentrequest'),
        headers: {
          "Accept": 'application/json',
          "ApiKey": OzowApi().ApiKey,
          "Content-Type": 'application/json',
        },
        body: json.encode(hash));
    postPaymentUrl = json.decode(resp.body)["url"];



    return json.decode(resp.body);

  }


  dynamic paymentStatus()async{
    // This will let us know whether or not the payment made was successful
    while(paymentStatusResponse !="Complete" || paymentStatusResponse !="Cancelled") {
      var response = await http
          .get(
          Uri.parse(
              "https://api.ozow.com/GetTransactionByReference?siteCode=${OzowApi().SiteCode}&transactionReference=$reference"),
          headers: {
            "Accept": 'application/json',
            "ApiKey": OzowApi().ApiKey,
            "Content-Type": 'application/json',
          }
      );
      try {
        var responseMap = json.decode(response.body)
            .asMap(); // takes the response which is a string and converts it to a map so we can get status of payment

        paymentStatusResponse = responseMap[0]["status"];

        if(paymentStatusResponse=="Complete" || paymentStatusResponse == "Cancelled" || paymentStatusResponse=="Error" || paymentStatusResponse == "Abandoned" || paymentStatusResponse=="PendingInvestigation" || paymentStatusResponse == "Pending"){
          bankName = responseMap[0]["bankName"];
          transactionId = responseMap[0]["transactionId"];
          createdDate = responseMap[0]["CreatedDate"];
          paymentDate = responseMap[0]["PaymentDate"];
          subStatus = responseMap[0]["SubStatus"];
          statusMessage = responseMap[0]["StatusMessage"];
          currencyCode = responseMap[0]["CurrencyCode"];
          FirebaseFirestore.instance.collection("Donations").add({
            "PaymentStatusResponse": paymentStatusResponse,
            "Amount": amount,
            "Reference": reference,
            "Bank":bankName,
            "TransactionId":transactionId,
            "CreatedDate":createdDate,
            "PaymentDate":paymentDate,
            "SubStatus":subStatus,
            "StatusMessage":statusMessage,
            "CurrencyCode":currencyCode,
            "User":uid

          });
          notifyListeners();

          break;
        }

      }
      catch(e){

        print("Noooooooooooooooooooooooooooooooooo!!!!!! The error is : $e ");
      }
    }
    notifyListeners();
    return paymentStatusResponse;
  }






}