public with sharing class HelloWorld {
    public String unusedVar; // unused variable - PMD should flag this
    public String greet(String name) {
        return 'Hello, ' + name;
    }
}