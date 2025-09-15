@isTest
public class DheerajTestTest {
    
    @isTest
    static void testGreet() {
        DheerajTest obj = new DheerajTest();
        String result = obj.greet('Dheeraj');
        System.assertEquals('Hello, Dheeraj', result);
    }

    @isTest
    static void testGreetOne() {
        DheerajTest obj = new DheerajTest();
        String result = obj.greetOne('Dheeraj');
        System.assertEquals('Hello, Dheeraj', result);
    }
}
