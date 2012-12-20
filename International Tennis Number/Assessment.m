//
//  Assessment.m
//  International Tennis Number
//
//  Created by Robson Ximenes on 17/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import "Assessment.h"
#import "Stroke.h"
#import "AppDelegate.h"

#define MOBILITY_SCORE [NSArray arrayWithObjects: [NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3],[NSNumber numberWithInt:4],[NSNumber numberWithInt:5],[NSNumber numberWithInt:6],[NSNumber numberWithInt:7],[NSNumber numberWithInt:8],[NSNumber numberWithInt:9],[NSNumber numberWithInt:10],[NSNumber numberWithInt:11],[NSNumber numberWithInt:12],[NSNumber numberWithInt:12],[NSNumber numberWithInt:14],[NSNumber numberWithInt:15],[NSNumber numberWithInt:16],[NSNumber numberWithInt:18],[NSNumber numberWithInt:19],[NSNumber numberWithInt:21],[NSNumber numberWithInt:26],[NSNumber numberWithInt:32],[NSNumber numberWithInt:39],[NSNumber numberWithInt:45],[NSNumber numberWithInt:52],[NSNumber numberWithInt:61],[NSNumber numberWithInt:75],nil]

#define MALE_ITN_SCORE [NSArray arrayWithObjects: [NSNumber numberWithInt:75],[NSNumber numberWithInt:104],[NSNumber numberWithInt:139],[NSNumber numberWithInt:175],[NSNumber numberWithInt:209],[NSNumber numberWithInt:244],[NSNumber numberWithInt:268],[NSNumber numberWithInt:293],[NSNumber numberWithInt:337],[NSNumber numberWithInt:362],[NSNumber numberWithInt:430],nil]

#define FEMALE_ITN_SCORE [NSArray arrayWithObjects: [NSNumber numberWithInt:57],[NSNumber numberWithInt:79],[NSNumber numberWithInt:108],[NSNumber numberWithInt:140],[NSNumber numberWithInt:171],[NSNumber numberWithInt:205],[NSNumber numberWithInt:230],[NSNumber numberWithInt:258],[NSNumber numberWithInt:303],[NSNumber numberWithInt:344],[NSNumber numberWithInt:430],nil]

@implementation Assessment


@synthesize name,birthday,sex,assessor,date,local,groundStrokeDeph,volleyDeph,groundStrokePrecision,server,mobilityTime;

@synthesize strokesForGSAccuracy,strokesForGSDeph,strokesForServer,strokesForVolleyDeph;


@synthesize itn,gsDephPoints,gsAccuracyPoints,serverPoints,volleyDephPoints,mobilityPoints;

static Assessment *instance = NULL;

+ (Assessment *)current{
    @synchronized(self){
        if (!instance) instance = [[Assessment alloc] init];
    }
    return(instance);
}

+ (void) clearInstance{
    instance = nil;
}


-(id)init
{
    if (self = [super init]){
        groundStrokeDeph = [[NSMutableArray alloc] initWithCapacity:10];
        volleyDeph = [[NSMutableArray alloc] initWithCapacity:8];
        groundStrokePrecision = [[NSMutableArray alloc] initWithCapacity:12];
        server = [[NSMutableArray alloc] initWithCapacity:12];
    }
    return self;
}

- (int) getGroundStrokePoints{
    int points = 0;
    for (int i =0; i<[groundStrokeDeph count]; i++) {
        points+= [((NSNumber*)[groundStrokeDeph objectAtIndex:i]) intValue];
    }
    return points;
}
- (int) getGroundStrokeConssistencyPoints{
    int points = 0;
    for (int i =0; i<[groundStrokeDeph count]; i++) {
        int p = [((NSNumber*)[groundStrokeDeph objectAtIndex:i]) intValue];
        if(p>0){
            points++;
        }
    }
    return points;
}
- (int) getGroundStrokeTotalPoints{
    return [self getGroundStrokePoints]+[self getGroundStrokeConssistencyPoints];
}

- (int) getVolleyDephPoints{
    int points = 0;
    for (int i =0; i<[volleyDeph count]; i++) {
        points+= [((NSNumber*)[volleyDeph objectAtIndex:i]) intValue];
    }
    return points;
}

- (int) getVolleyDephConssistencyPoints{
    int points = 0;
    for (int i =0; i<[volleyDeph count]; i++) {
        if([((NSNumber*)[volleyDeph objectAtIndex:i]) intValue]>0){
            points++;
        }
    }
    return points;
}

- (int) getVolleyDephTotalPoints{
    return [self getVolleyDephPoints]+[self getVolleyDephConssistencyPoints];
}


- (int) getGSAccuracyPoints{
    int points = 0;
    for (int i =0; i<[groundStrokePrecision count]; i++) {
        points+= [((NSNumber*)[groundStrokePrecision objectAtIndex:i]) intValue];
    }
    return points;
}

- (int) getGSAccuracyConssistencyPoints{
    int points = 0;
    for (int i =0; i<[groundStrokePrecision count]; i++) {
        if([((NSNumber*)[groundStrokePrecision objectAtIndex:i]) intValue]>0){
            points++;
        }
    }
    return points;
}

- (int) getGSAccuracyTotalPoints{
    return [self getGSAccuracyPoints]+[self getGSAccuracyConssistencyPoints];
}
            

- (int) getServerPoints{
    int points = 0;
    for (int i =0; i<[server count]; i++) {
        points+= [((NSNumber*)[server objectAtIndex:i]) intValue];
    }
    return points;
}

- (int) getServerConssistencyPoints{
    int points = 0;
    for (int i =0; i<[server count]; i++) {
        if([((NSNumber*)[server objectAtIndex:i]) intValue]>0){
            points++;
        }
    }
    return points;
}

- (int) getServerTotalPoints{
    return [self getServerPoints]+[self getServerConssistencyPoints];
}


- (int) getStrokePoints{
    return [self getGroundStrokeTotalPoints]+ [self getVolleyDephTotalPoints] + [self getGSAccuracyTotalPoints] + [self getServerTotalPoints];
}
- (int) getMobilityPoints{
    int points = 0;
    if(mobilityTime==0){
        points = 0;
    }else if(mobilityTime<15){
        points = [((NSNumber*)[MOBILITY_SCORE objectAtIndex:25]) intValue];
    }else if(mobilityTime>40){
        points = [((NSNumber*)[MOBILITY_SCORE objectAtIndex:0]) intValue];
    }else{
        points = [((NSNumber*)[MOBILITY_SCORE objectAtIndex:40 - mobilityTime]) intValue];
    }
    
    return points;
}
- (int) getTotalPoints{
    return [self getStrokePoints]+[self getMobilityPoints];
}

- (int) calculateITN{
    int theItn = 10;
    int score = [self getTotalPoints];
    NSArray *points = NULL;
    if([sex isEqualToString:@"F"]){
        points = FEMALE_ITN_SCORE;
    }else{
        points = MALE_ITN_SCORE;
    }
    for (int i =0; i<[points count]; i++) {
        int max = [((NSNumber*)[points objectAtIndex:i]) intValue];
        if(score<= max){
            theItn = 11-i;
            break;
        }
    }
    
    return theItn;
}


-(NSMutableArray *) getStrokesForGSAccuracy{
    if(!strokesForGSAccuracy){
        NSMutableArray *strokes = [[NSMutableArray alloc] init];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"1" strokName:@"Forehand DL" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"2" strokName:@"Backhand DL" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"3" strokName:@"Forehand DL" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"4" strokName:@"Backhand DL" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"5" strokName:@"Forehand DL" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"6" strokName:@"Backhand DL" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"7" strokName:@"Forehand CC" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"8" strokName:@"Backhand CC" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"9" strokName:@"Forehand CC" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"10" strokName:@"Backhand CC" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"11" strokName:@"Forehand CC" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"12" strokName:@"Backhand CC" score:@"0" ]];
        strokesForGSAccuracy = strokes;
    }
    return strokesForGSAccuracy;
}

-(NSMutableArray *) getStrokesForGSDeph{
    if(!strokesForGSDeph){
        NSMutableArray *strokes = [[NSMutableArray alloc] init];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"1" strokName:@"Forehand" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"2" strokName:@"Backhand" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"3" strokName:@"Forehand" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"4" strokName:@"Backhand" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"5" strokName:@"Forehand" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"6" strokName:@"Backhand" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"7" strokName:@"Forehand" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"8" strokName:@"Backhand" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"9" strokName:@"Forehand" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"10" strokName:@"Backhand" score:@"0" ]];
        strokesForGSDeph = strokes;
    }
    return strokesForGSDeph;
}

-(NSMutableArray *) getStrokesForVolleyDeph{
    if(!strokesForVolleyDeph){
        NSMutableArray *strokes = [[NSMutableArray alloc] init];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"1" strokName:@"Forehand" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"2" strokName:@"Backhand" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"3" strokName:@"Forehand" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"4" strokName:@"Backhand" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"5" strokName:@"Forehand" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"6" strokName:@"Backhand" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"7" strokName:@"Forehand" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"8" strokName:@"Backhand" score:@"0" ]];
        strokesForVolleyDeph = strokes;
    }
    return strokesForVolleyDeph;
}

-(NSMutableArray *) getStrokesForServer{
    if(!strokesForServer){
        NSMutableArray *strokes = [[NSMutableArray alloc] init];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"1" strokName:@"Forehand DL" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"2" strokName:@"Backhand DL" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"3" strokName:@"Forehand DL" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"4" strokName:@"Backhand DL" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"5" strokName:@"Forehand DL" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"6" strokName:@"Backhand DL" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"7" strokName:@"Forehand CC" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"8" strokName:@"Backhand CC" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"9" strokName:@"Forehand CC" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"10" strokName:@"Backhand CC" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"11" strokName:@"Forehand CC" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"12" strokName:@"Backhand CC" score:@"0" ]];
        strokesForServer = strokes;
    }
    return strokesForServer;
}


//GS Deph   : 0,1,2,3,4,5,6,8
//VO Deph   : 0,1,2,3,4,5,6,8
//GS Accu   : 0,1,2,3,4,6
//Service   : 0,1,2,3,4,5,8
+(NSArray *) getPointsForGSAccuracy{
    return [NSArray arrayWithObjects: @"0",@"1", @"2", @"3", @"4", @"6", nil];
}

+(NSArray *) getPointsForGSDeph{
    return [NSArray arrayWithObjects: @"0",@"1", @"2", @"3", @"4", @"5", @"6", @"8", nil];
}

+(NSArray *) getPointsForVolleyDeph{
    return [NSArray arrayWithObjects: @"0",@"1", @"2", @"3", @"4", @"5", @"6", @"8", nil];
}

+(NSArray *) getPointsForServer{
    return [NSArray arrayWithObjects: @"0",@"1", @"2", @"3", @"4", @"5", @"8", nil];
}


#pragma mark Persistencia

-(NSManagedObject *) fetch{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *contexto=[appDelegate managedObjectContext];
    NSFetchRequest *fetch = [[NSFetchRequest alloc] initWithEntityName:@"Assessment"];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(name = %@)", self.name];
    
    [fetch setPredicate:pred];
    
    NSError *error;
    NSArray *objects = [contexto executeFetchRequest:fetch error:&error];
    NSManagedObject *object;
    
    if([objects count]==0){
        object = nil;
    }else{
        object = [objects objectAtIndex:0];
    }

    return object;
}

-(void) save{
    
    NSManagedObject *object = [self fetch];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *contexto=[appDelegate managedObjectContext];
    
    if(!object){
        object = [NSEntityDescription
                    insertNewObjectForEntityForName:@"Assessment"
                    inManagedObjectContext:contexto];
    }
    
    if(!self.date){
        self.date = [[NSDate alloc]init];
    }
    
    [object setValue:self.name forKey:@"name"];
    [object setValue:self.birthday forKey:@"birthday"];
    [object setValue:self.sex forKey:@"sex"];
    [object setValue:self.assessor forKey:@"assessor"];
    [object setValue:self.date forKey:@"date"];
    [object setValue:self.local forKey:@"venue"];
    
    [object setValue: [NSNumber numberWithInt:[self getGroundStrokeTotalPoints]] forKey:@"gsDephPoints"];
    [object setValue: [NSNumber numberWithInt:[self getGSAccuracyTotalPoints]] forKey:@"gsAccuracyPoints"];
    [object setValue: [NSNumber numberWithInt:[self getVolleyDephTotalPoints]] forKey:@"volleyDephPoints"];
    [object setValue: [NSNumber numberWithInt:[self getServerPoints]] forKey:@"serverPoints"];
    [object setValue: [NSNumber numberWithInt:[self getMobilityPoints]] forKey:@"mobility"];
    [object setValue: [NSNumber numberWithInt:[self calculateITN]] forKey:@"itn"];
    
    
    
    NSError *error;
    [contexto save:&error];
    
    if(error){
        NSLog(@"Erro ao salvar: %@",error);
    }


}

-(NSArray *)findAll{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *contexto=[appDelegate managedObjectContext];
    NSFetchRequest *fetch = [[NSFetchRequest alloc] initWithEntityName:@"Assessment"];
    NSSortDescriptor *dateOrder = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSSortDescriptor *nomeOrder = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    
    fetch.sortDescriptors = [NSArray arrayWithObjects:dateOrder,nomeOrder, nil];
    
    NSError *error;
    NSArray *objects = [contexto executeFetchRequest:fetch error:&error];
    
    NSMutableArray *assessments = [NSMutableArray array];
    for (NSManagedObject *object in objects) {
        Assessment *a = [[Assessment alloc]init];
        [a setAssessor:[object valueForKey:@"assessor"]];
        [a setBirthday:[object valueForKey:@"birthday"]];
        [a setDate:[object valueForKey:@"date"]];
        [a setLocal:[object valueForKey:@"venue"]];
        [a setName:[object valueForKey:@"name"]];
        [a setSex:[object valueForKey:@"sex"]];
        
        
        NSNumber *gsDephP = [object valueForKey:@"gsDephPoints"];
        NSNumber *gsAccuracyP = [object valueForKey:@"gsAccuracyPoints"];
        NSNumber *volleyDephP = [object valueForKey:@"volleyDephPoints"];
        NSNumber *serverP = [object valueForKey:@"serverPoints"];
        NSNumber *mobilityP = [object valueForKey:@"mobility"];
        NSNumber *itnP = [object valueForKey:@"itn"];
        
        
        
        [a setGsDephPoints:[gsDephP integerValue]];
        [a setGsAccuracyPoints: [gsAccuracyP integerValue]];
        [a setVolleyDephPoints: [volleyDephP integerValue]];
        [a setServerPoints:[serverP integerValue]];
        [a setMobilityPoints:[mobilityP integerValue]];
        [a setItn:[itnP integerValue]];
        
        
        [assessments addObject:a];
    }
    
    return assessments;
}

+(void) configureSampleAssessment{
    
    Assessment *sample = [[Assessment alloc]init];
    [sample setName:@"Robson Ximenes"];
    [sample setBirthday:[[NSDate alloc] init]];
    [sample setSex:@"M"];
    [sample setAssessor:@"Ary Godoy"];
    [sample setDate:[[NSDate alloc] init]];
    [sample setLocal:@"Winner Tennis"];
    
    [sample setMobilityTime:18];
    
    NSNumber *gsDephsPoint = [NSNumber numberWithInt:[(NSString *)[[Assessment getPointsForGSDeph] lastObject] intValue]];
    NSNumber * gsAccuracyPoint = [NSNumber numberWithInt:[(NSString *)[[Assessment getPointsForGSAccuracy] lastObject] intValue]];
    NSNumber * serverPoint = [NSNumber numberWithInt:[(NSString *)[[Assessment getPointsForServer] lastObject] intValue]];
    NSNumber * volleyPoint = [NSNumber numberWithInt:[(NSString *)[[Assessment getPointsForVolleyDeph] lastObject] intValue]];
    
    int i = 0;
    for ( Stroke *s in [sample getStrokesForGSDeph]) {
        [sample.groundStrokeDeph setObject:gsDephsPoint atIndexedSubscript:i++];
    }
    i = 0;
    for ( Stroke *s in [sample getStrokesForGSAccuracy]) {
        [sample.groundStrokePrecision setObject:gsAccuracyPoint atIndexedSubscript:i++];
    }
    i = 0;
    for ( Stroke *s in [sample getStrokesForServer]) {
        [sample.server setObject:serverPoint atIndexedSubscript:i++];
    }
    i = 0;
    for ( Stroke *s in [sample getStrokesForVolleyDeph]) {
        [sample.volleyDeph setObject:volleyPoint atIndexedSubscript:i++];
    }
    
    [sample save];
    
}

@end
