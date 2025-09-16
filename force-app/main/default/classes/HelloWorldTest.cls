@isTest
public class HelloWorldTest {
    
    @isTest
    static void testGreet() {
        HelloWorld obj = new HelloWorld();
        String result = obj.greet('Dheeraj');
        System.assertEquals('Hello, Dheeraj', result);
    }

    @isTest
    static void testGreetOne() {
        HelloWorld obj = new HelloWorld();
        String result = obj.greetOne('Dheeraj');
        System.assertEquals('Hello, Dheeraj', result);
    }

    @isTest
    static void testGreetTwo() {
        HelloWorld obj = new HelloWorld();
        String result = obj.greetTwo('Dheeraj');
        System.assertEquals('Hello, Dheeraj', result);
    }
}
