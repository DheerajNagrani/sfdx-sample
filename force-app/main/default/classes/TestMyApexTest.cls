@isTest
public class TestMyApexTest {
    
    @isTest
    static void testGreet() {
        TestMyApex obj = new TestMyApex();
        String result = obj.greet('Dheeraj');
        System.assertEquals('Hello, Dheeraj', result);
    }
}
