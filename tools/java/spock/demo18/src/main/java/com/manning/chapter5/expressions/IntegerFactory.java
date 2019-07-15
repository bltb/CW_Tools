package com.manning.chapter5.expressions;

public class IntegerFactory {

	public static int createFrom(String number)
	{
		return MyInteger.valueOf(number.toUpperCase()).getNumber();
	}
}
