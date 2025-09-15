@isTest
public class MyDeveloperTestTest {
    

    @isTest
    static void testGreet() {
        MyDeveloperTest obj = new MyDeveloperTest();
        String result = obj.greet('Dheeraj');
        System.assertEquals('Hello, Dheeraj', result);
    }
}
