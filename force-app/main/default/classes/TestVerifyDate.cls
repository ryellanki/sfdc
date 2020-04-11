@isTest
public class TestVerifyDate {
    
 @isTest static void testDate1CheckDates()
 {
     Date date1=Date.newInstance(2017, 3, 17);
     Date date2=Date.newInstance(2017, 2, 17);
     Date test1=VerifyDate.CheckDates(date1,date2);
     Date date3=Date.newInstance(2017,3,31);
     System.assertEquals(date3, test1);
     
 }
    
    @isTest static void testDate2CheckDates()
 {
     Date date1=Date.newInstance(2017, 2, 17);
     Date date2=Date.newInstance(2017, 3, 17);
     Date test1=VerifyDate.CheckDates(date1,date2);
     System.assertEquals(date2, test1);
 }
}