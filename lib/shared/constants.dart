import 'package:form_validator/form_validator.dart';
import 'package:flutter/material.dart';

final validatePassword =
    ValidationBuilder().required().minLength(6).maxLength(20).build();

final validateEmail = ValidationBuilder()
    .required("This Field is Required")
    .email()
    .maxLength(50)
    .build();

const buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(18.0)));

const buttonPadding =
    EdgeInsets.only(left: 35.0, right: 35.0, top: 10.0, bottom: 10.0);
