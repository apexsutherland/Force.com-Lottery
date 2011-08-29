public class LotteryController {

    private Contestant__c[] players { get; set; }
    public Integer size { get; set; }
    public String winnerName { get; set; }
    public Double seed { get; set; }
    public Integer pick { get; set; }

    public LotteryController() {
        players = [SELECT Name FROM Contestant__c];
        size = players.size();
    }

    public PageReference winner() {
        Integer max = players.size()-1;
        pick = randomNumber(max);
        winnerName = players.get(pick).Name;
        return null;
    }

    public Integer randomNumber(Integer range) {
        seed = math.random();
        Double gen = seed * (range - 1);
        return gen.intValue();
    }

    static testMethod void pickAWinner(){
        Contestant__c[] contestants = new Contestant__c[]{};
        for(Integer i = 0; i < 10; i++) {
            Contestant__c c = new Contestant__c(Name = 'Test' + i);
            contestants.add(c);
        }
        insert contestants;
        
        Test.startTest();
            LotteryController lc =  new LotteryController();
            lc.winner();
            System.assertNotEquals(lc.winnerName,null);
        Test.stopTest();
    }
}