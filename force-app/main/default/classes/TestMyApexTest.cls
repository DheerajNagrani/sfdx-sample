@isTest
public class TestMyApexTest {
    
    @isTest
    static void testConstructor() {
        // Act: create an instance of HelloWorld
        TestMyApexTest obj = new TestMyApexTest();
        
        // Assert: ensure the object is created
        System.assertNotEquals(null, obj, 'TestMyApexTest constructor should return a valid object');
    }
}
