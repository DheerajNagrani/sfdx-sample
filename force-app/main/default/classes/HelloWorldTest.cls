@isTest
public class HelloWorldTest {
    
    @isTest
    static void testConstructor() {
        // Act: create an instance of HelloWorld
        HelloWorld obj = new HelloWorld();
        
        // Assert: ensure the object is created
        System.assertNotEquals(null, obj, 'HelloWorld constructor should return a valid object');
    }
}
