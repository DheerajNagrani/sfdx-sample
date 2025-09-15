@isTest
public class MyDevelopTestTest {
    

    @isTest
    static void testGreet() {
        MyDevelopTest obj = new MyDevelopTest();
        String result = obj.greet('Dheeraj');
        System.assertEquals('Hello, Dheeraj', result);
    }
}
