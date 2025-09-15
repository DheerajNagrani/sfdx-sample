@isTest
public class MyDeveloperTestTest {
    
    @isTest
    static void testConstructor() {
        // Act: create an instance of HelloWorld
        MyDeveloperTestTest obj = new MyDeveloperTestTest();
        
        // Assert: ensure the object is created
        System.assertNotEquals(null, obj, 'MyDeveloperTestTest constructor should return a valid object');
    }
    @isTest
    static void testGreet() {
        MyDeveloperTest obj = new MyDeveloperTest();
        String result = obj.greet('Dheeraj');
        System.assertEquals('Hello, Dheeraj', result);
    }
}
