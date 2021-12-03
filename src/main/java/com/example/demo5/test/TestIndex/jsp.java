package com.example.demo5.test.TestIndex;

import org.junit.Test;

import java.util.Arrays;
import java.util.Optional;

public class jsp {
    @Test
    public void TestString(){
        String[] arr = {"tt","a","v"};

        System.out.println(Arrays.stream(arr).filter(i -> i.equals("d")).findFirst());
        Optional.of("d");
    }
}
