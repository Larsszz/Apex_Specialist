public class MaintenanceRequestHelper {

    public static void updateWorkOrders(Map<Id, Case> newCasesMap, Map<Id, Case> oldCasesMap) {
        List<Id> checkedCases = new List<Id>();
        Map<Id, List<Work_Part__c>> workPartToCasesMap = new Map<Id, List<Work_Part__c>>();
        Map<Integer, List<Work_Part__c>> insertWps = new Map<Integer, List<Work_Part__c>>();
        List<Work_Part__c> workPartsToInsert = new List<Work_Part__c>();
        Map<Integer, Case> insertCases = new Map<Integer, Case>();
        Integer iterator = 0;
        for (Id caseId : newCasesMap.keySet()) {
            if (oldCasesMap.get(caseId).Status != 'Closed' && newCasesMap.get(caseId).Status == 'Closed' &&
                    (newCasesMap.get(caseId).Type == 'Repair' || newCasesMap.get(caseId).Type == 'Routine Maintenance')) {
                checkedCases.add(caseId);
            }
        }
        List<Work_Part__c> workPartsFromCases = [
                SELECT Id, Name, Equipment__r.Maintenance_Cycle__c, Maintenance_Request__c,
                        Quantity__c, Equipment__c
                FROM Work_Part__c
                WHERE Maintenance_Request__c IN :checkedCases
        ];
        for (Work_Part__c workPart : workPartsFromCases) {
            if (workPartToCasesMap.containsKey(workPart.Maintenance_Request__c)) {
                List<Work_Part__c> buffer = workPartToCasesMap.get(workPart.Maintenance_Request__c);
                buffer.add(workPart);
                workPartToCasesMap.put(workPart.Maintenance_Request__c, buffer);
            } else {
                workPartToCasesMap.put(workPart.Maintenance_Request__c, new List<Work_Part__c>{
                        workPart
                });
            }
        }
        for (Id caseId : checkedCases) {
            List<Work_Part__c> workPartsByCase = workPartToCasesMap.get(caseId);
            List<Work_Part__c> workPartsBuffer = new List<Work_Part__c>();
            Integer minCycleDays;
            if (workPartsByCase == null || workPartsByCase.size() == 0) {
                minCycleDays = 0;
            } else {
                for (Work_Part__c workPart : workPartsByCase) {
                    if (minCycleDays == null || minCycleDays >= workPart.Equipment__r.Maintenance_Cycle__c.intValue()) {
                        minCycleDays = workPart.Equipment__r.Maintenance_Cycle__c.intValue();
                        Work_Part__c buffer = new Work_Part__c();
                        buffer.Equipment__c = workPart.Equipment__c;
                        buffer.Quantity__c = workPart.Quantity__c;
                        workPartsBuffer.add(buffer);
                    }
                }
            }
            Case tempCase = newCasesMap.get(caseId);
            Case caseToInsert = new Case();
            caseToInsert.Type = 'Routine Maintenance';
            caseToInsert.Status = 'New';
            caseToInsert.Origin = tempCase.Origin;
            caseToInsert.Vehicle__c = tempCase.Vehicle__c;
            caseToInsert.Equipment__c = tempCase.Equipment__c;
            caseToInsert.Subject = null;
            caseToInsert.Date_Reported__c = System.today();
            caseToInsert.Date_Due__c = System.today().addDays(minCycleDays);
            insertCases.put(iterator, caseToInsert);
            insertWps.put(iterator, workPartsBuffer);
            iterator++;
        }
        insert insertCases.values();
        for (Integer iter : insertCases.keySet()) {
            for (Work_Part__c workPart : insertWps.get(iter)) {
                workPart.Maintenance_Request__c = insertCases.get(iter).Id;
                workPartsToInsert.add(workPart);
            }
        }
        insert workPartsToInsert;
    }
}