@isTest
public class MyDevelopTestTest {
    

    @isTest
    static void testGreet() {
        MyDevelopTestTest obj = new MyDevelopTestTest();
        String result = obj.greet('Dheeraj');
        System.assertEquals('Hello, Dheeraj', result);
    }
}
