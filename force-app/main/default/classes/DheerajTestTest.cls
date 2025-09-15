@isTest
public class DheerajTestTest {
    
    @isTest
    static void testGreet() {
        DheerajTest obj = new DheerajTest();
        String result = obj.greet('Dheeraj');
        System.assertEquals('Hello, Dheeraj', result);
    }
}
