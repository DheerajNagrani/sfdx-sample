@isTest
public class HelloWorldTest {
    
    @isTest
    static void testGreet() {
        HelloWorld obj = new HelloWorld();
        String result = obj.greet('Dheeraj');
        System.assertEquals('Hello, Dheeraj', result);
    }
}
