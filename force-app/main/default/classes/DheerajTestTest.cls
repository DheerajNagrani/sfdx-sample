@isTest
public class DheerajTestTest {
    
    @isTest
    static void testConstructor() {
        // Act: create an instance of HelloWorld
        DheerajTestTest obj = new DheerajTestTest();
        
        // Assert: ensure the object is created
        System.assertNotEquals(null, obj, 'DheerajTestTest constructor should return a valid object');
    }
}
