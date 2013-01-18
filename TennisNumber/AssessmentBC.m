//
//  Assessment.m
//  International Tennis Number
//
//  Created by Robson Ximenes on 17/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import "AssessmentBC.h"
#import "Assessment.h"
#import "Stroke.h"
#import "AppDelegate.h"

#define MOBILITY_SCORE [NSArray arrayWithObjects: [NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3],[NSNumber numberWithInt:4],[NSNumber numberWithInt:5],[NSNumber numberWithInt:6],[NSNumber numberWithInt:7],[NSNumber numberWithInt:8],[NSNumber numberWithInt:9],[NSNumber numberWithInt:10],[NSNumber numberWithInt:11],[NSNumber numberWithInt:12],[NSNumber numberWithInt:12],[NSNumber numberWithInt:14],[NSNumber numberWithInt:15],[NSNumber numberWithInt:16],[NSNumber numberWithInt:18],[NSNumber numberWithInt:19],[NSNumber numberWithInt:21],[NSNumber numberWithInt:26],[NSNumber numberWithInt:32],[NSNumber numberWithInt:39],[NSNumber numberWithInt:45],[NSNumber numberWithInt:52],[NSNumber numberWithInt:61],[NSNumber numberWithInt:76],nil]

#define MALE_ITN_SCORE [NSArray arrayWithObjects: [NSNumber numberWithInt:75],[NSNumber numberWithInt:104],[NSNumber numberWithInt:139],[NSNumber numberWithInt:175],[NSNumber numberWithInt:209],[NSNumber numberWithInt:244],[NSNumber numberWithInt:268],[NSNumber numberWithInt:293],[NSNumber numberWithInt:337],[NSNumber numberWithInt:362],[NSNumber numberWithInt:430],nil]

#define FEMALE_ITN_SCORE [NSArray arrayWithObjects: [NSNumber numberWithInt:57],[NSNumber numberWithInt:79],[NSNumber numberWithInt:108],[NSNumber numberWithInt:140],[NSNumber numberWithInt:171],[NSNumber numberWithInt:205],[NSNumber numberWithInt:230],[NSNumber numberWithInt:258],[NSNumber numberWithInt:303],[NSNumber numberWithInt:344],[NSNumber numberWithInt:430],nil]




@implementation AssessmentBC

@synthesize ctx, assessment;

static AssessmentBC *instance = NULL;


+ (AssessmentBC *)current{
    @synchronized(self){
        if (!instance){
            instance = [[AssessmentBC alloc] init];
            
        }
    }
    return(instance);
}

+ (void) clearInstance{
    instance = nil;
}


-(id)init
{
    if (self = [super init]){
        [self setCtx:[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]];
    }
    return self;
}

-(Assessment *) createAssessment{
    Assessment *a = [[Assessment alloc] initWithContext: [self ctx]];
    
    NSNumber *type = [NSNumber numberWithInt:STROKE_TYPE_GS_ACCURACY];
    NSArray *strokeNames = [AssessmentBC getStrokesNamesForType:type];
    for(int i=0; i< [strokeNames count]; i++){
        NSString *number = [NSString stringWithFormat:@"%d",i+1];
        NSString *name = [[AssessmentBC getStrokesNamesForType:type] objectAtIndex:i];
        Stroke * stroke =[[Stroke alloc] initWithNumber:number strokName:name score:@"0" type:type context:[self ctx]];
        [stroke setAssessment:a];
    }
    type = [NSNumber numberWithInt:STROKE_TYPE_GS_DEPH];
    strokeNames = [AssessmentBC getStrokesNamesForType:type];
    for(int i=0; i< [strokeNames count]; i++){
        NSString *number = [NSString stringWithFormat:@"%d",i+1];
        NSString *name = [[AssessmentBC getStrokesNamesForType:type] objectAtIndex:i];
        Stroke * stroke =[[Stroke alloc] initWithNumber:number strokName:name score:@"0" type:type context:[self ctx]];
        [stroke setAssessment:a];
    }
    type = [NSNumber numberWithInt:STROKE_TYPE_VOLLEY_DEPH];
    strokeNames = [AssessmentBC getStrokesNamesForType:type];
    for(int i=0; i< [strokeNames count]; i++){
        NSString *number = [NSString stringWithFormat:@"%d",i+1];
        NSString *name = [[AssessmentBC getStrokesNamesForType:type] objectAtIndex:i];
        Stroke * stroke =[[Stroke alloc] initWithNumber:number strokName:name score:@"0" type:type context:[self ctx]];
        [stroke setAssessment:a];
    }
    type = [NSNumber numberWithInt:STROKE_TYPE_SERVER];
    strokeNames = [AssessmentBC getStrokesNamesForType:type];
    for(int i=0; i< [strokeNames count]; i++){
        NSString *number = [NSString stringWithFormat:@"%d",i+1];
        NSString *name = [[AssessmentBC getStrokesNamesForType:type] objectAtIndex:i];
        Stroke * stroke =[[Stroke alloc] initWithNumber:number strokName:name score:@"0" type:type context:[self ctx]];
        [stroke setAssessment:a];
    }
    
    NSError *error;
    [[self ctx] save:&error];
    if(error){
        NSLog(@"Erro ao excluir: %@",error);
    }

    return a;
}


+(NSArray *) getStrokesNamesForType: (NSNumber *) type{
    NSArray *strokes = nil;
    static NSArray *gsAccuracyArrayOfNames;
    static NSArray *gsDephArrayOfNames;
    static NSArray *volleyArrayOfNames;
    static NSArray *serverArrayOfNames;
    
    static NSString *FORHAND_DL;
    static NSString *BACKHAND_DL;
    static NSString *FORHAND_CC;
    static NSString *BACKHAND_CC;
    static NSString *FORHAND;
    static NSString *BACKHAND;
    static NSString *SERVER_1ST_WIDE;
    static NSString *SERVER_1ST_MIDDLE;
    static NSString *SERVER_2ST_WIDE;
    static NSString *SERVER_2ST_MIDDLE;
    
    if(!FORHAND_DL) FORHAND_DL = NSLocalizedString(@"Forehand DL", @"A forehand down the line");
    if(!BACKHAND_DL) BACKHAND_DL = NSLocalizedString(@"Backhand DL", @"A backhand down the line");
    if(!FORHAND_CC) FORHAND_CC = NSLocalizedString(@"Forehand CC", @"A forehand crossing court");
    if(!BACKHAND_CC) BACKHAND_CC = NSLocalizedString(@"Backhand CC", @"A backhand crossing court");
    if(!FORHAND) FORHAND = NSLocalizedString(@"Forehand", @"A forehand");
    if(!BACKHAND) BACKHAND = NSLocalizedString(@"Backhand", @"A backhand");
    if(!SERVER_1ST_WIDE) SERVER_1ST_WIDE = NSLocalizedString(@"1st Box Wide", @"1st service Wide");
    if(!SERVER_1ST_MIDDLE) SERVER_1ST_MIDDLE = NSLocalizedString(@"1st Box Middle", @"1st service Middle");
    if(!SERVER_2ST_WIDE) SERVER_2ST_WIDE = NSLocalizedString(@"2st Box Wide", @"2st service Wide");
    if(!SERVER_2ST_MIDDLE) SERVER_2ST_MIDDLE = NSLocalizedString(@"2st Box Middle", @"2st service middle");
    
    if(!gsAccuracyArrayOfNames)
        gsAccuracyArrayOfNames= [NSArray arrayWithObjects:
                           FORHAND_DL,BACKHAND_DL,
                           FORHAND_DL,BACKHAND_DL,
                           FORHAND_DL,BACKHAND_DL,
                           FORHAND_CC,BACKHAND_CC,
                           FORHAND_CC,BACKHAND_CC,
                           FORHAND_CC,BACKHAND_CC,nil];
    
    if(!gsDephArrayOfNames)
        gsDephArrayOfNames= [NSArray arrayWithObjects:
                             FORHAND, BACKHAND,
                             FORHAND, BACKHAND,
                             FORHAND, BACKHAND,
                             FORHAND, BACKHAND,
                             FORHAND, BACKHAND,nil];
    
    if(!volleyArrayOfNames)
        volleyArrayOfNames= [NSArray arrayWithObjects:
                             FORHAND, BACKHAND,
                             FORHAND, BACKHAND,
                             FORHAND, BACKHAND,
                             FORHAND, BACKHAND,nil];
    
    
    if(!serverArrayOfNames)
        serverArrayOfNames= [NSArray arrayWithObjects:
                             SERVER_1ST_WIDE, SERVER_1ST_WIDE, SERVER_1ST_WIDE,
                             SERVER_1ST_MIDDLE, SERVER_1ST_MIDDLE, SERVER_1ST_MIDDLE,
                             SERVER_2ST_WIDE, SERVER_2ST_WIDE, SERVER_2ST_WIDE,
                             SERVER_2ST_MIDDLE, SERVER_2ST_MIDDLE, SERVER_2ST_MIDDLE, nil];
    
    if([type isEqualToNumber:[NSNumber numberWithInt:STROKE_TYPE_GS_ACCURACY]]){
        strokes = [NSArray arrayWithArray: gsAccuracyArrayOfNames];
    }else if([type isEqualToNumber:[NSNumber numberWithInt:STROKE_TYPE_GS_DEPH]]){
        strokes = [NSArray arrayWithArray: gsDephArrayOfNames];
    }else if([type isEqualToNumber:[NSNumber numberWithInt:STROKE_TYPE_VOLLEY_DEPH]]){
        strokes = [NSArray arrayWithArray: volleyArrayOfNames];
    }else if([type isEqualToNumber:[NSNumber numberWithInt:STROKE_TYPE_SERVER]]){
        strokes = [NSArray arrayWithArray: serverArrayOfNames];
    }
    
    return strokes;
}


//GS Deph   : 0,1,2,3,4,5,6,8
//VO Deph   : 0,1,2,3,4,5,6,8
//GS Accu   : 0,1,2,3,4,6
//Service   : 0,1,2,3,4,5,8
+(NSArray *) getPossiblePointsForType: (int) type{
    
    NSArray *possible = nil;
    
    if(type == STROKE_TYPE_GS_ACCURACY){
        possible = [NSArray arrayWithObjects:@(0),@(1),@(2),@(3),@(4),@(6), nil];
    }else if(type == STROKE_TYPE_GS_DEPH){
        possible = [NSArray arrayWithObjects:@(0),@(1),@(2),@(3),@(4),@(5),@(6),@(8), nil];
    }else if(type == STROKE_TYPE_VOLLEY_DEPH){
        possible = [NSArray arrayWithObjects:@(0),@(1),@(2),@(3),@(4),@(5),@(6),@(8), nil];
    }else if(type ==STROKE_TYPE_SERVER){
        possible = [NSArray arrayWithObjects:@(0),@(1),@(2),@(3),@(4),@(5),@(8), nil];
    }
    
    return possible;
}

-(NSArray *) getStrokesForType: (int) type{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSSet *strokes = [[self assessment] strokes];
    for (Stroke *s in strokes) {
        if([[s type] isEqualToNumber:[NSNumber numberWithInt:type]]){
            [array addObject:s];
        }
    }
    NSSortDescriptor *sortNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"order" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortNameDescriptor, nil];
    return[array sortedArrayUsingDescriptors:sortDescriptors];
    
}

- (int) getPointsForStrokeType: (int) type{
    int points = 0;
    NSArray *strokes = [self getStrokesForType:type];
    for (Stroke *s in strokes) {
        points+= [[s score] intValue];
    }
    return points;
}
- (int) getConssistencyPointsForStrokeType: (int) type{
    int points = 0;
    NSArray *strokes = [self getStrokesForType:type];
    for (Stroke *s in strokes) {
        if([[s score] intValue]>0){
            points++;
        }
    }
    return points;
}

- (int) getTotalPointsForStrokeType: (int) type{
    return [self getPointsForStrokeType:type]
    +[self getConssistencyPointsForStrokeType:type];
}


- (int) getStrokeTotalPoints{
    return [self getTotalPointsForStrokeType:STROKE_TYPE_GS_DEPH]
    + [self getTotalPointsForStrokeType:STROKE_TYPE_VOLLEY_DEPH]
    + [self getTotalPointsForStrokeType:STROKE_TYPE_GS_ACCURACY]
    + [self getTotalPointsForStrokeType: STROKE_TYPE_SERVER];
}
- (int) getMobilityPoints{
    int points = 0;
    int mobilityTime = [[[self assessment]mobilityTime] intValue];
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
    return [self getStrokeTotalPoints]+[self getMobilityPoints];
}


- (int) calculateITN{
    int theItn = 10;
    int score = [self getTotalPoints];
    NSArray *points = NULL;
    if([[[self assessment]sex] isEqualToString:@"F"]){
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



#pragma mark Persistencia

-(Assessment *) fetch{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *contexto=[appDelegate managedObjectContext];
    NSFetchRequest *fetch = [[NSFetchRequest alloc] initWithEntityName:@"Assessment"];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(name = %@)", [[self assessment] name]];
    
    [fetch setPredicate:pred];
    
    NSError *error;
    NSArray *objects = [contexto executeFetchRequest:fetch error:&error];
    NSManagedObject *object;
    
    if([objects count]==0){
        object = nil;
    }else{
        object = [objects objectAtIndex:0];
    }

    return (Assessment *)object;
}

-(void) save{
    [self save: assessment];
}

-(void) save:(Assessment *)a{
        
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *contexto=[appDelegate managedObjectContext];
    
    if(![a date]){
        [a setDate:[[NSDate alloc]init]];
    }
    
    [a setGsDephPoints: [NSNumber numberWithInt:[self getTotalPointsForStrokeType:STROKE_TYPE_GS_DEPH]] ];
    [a setGsAccuracyPoints: [NSNumber numberWithInt:[self getTotalPointsForStrokeType:STROKE_TYPE_GS_ACCURACY]] ];
    [a setVolleyDephPoints: [NSNumber numberWithInt:[self getTotalPointsForStrokeType:STROKE_TYPE_VOLLEY_DEPH]] ];
    [a setServerPoints: [NSNumber numberWithInt:[self getTotalPointsForStrokeType:STROKE_TYPE_SERVER]] ];
    [a setMobility: [NSNumber numberWithInt:[self getMobilityPoints]] ];
    [a setItn: [NSNumber numberWithInt:[self calculateITN]] ];
    
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
    
    return objects;
}

+(void) configureSampleAssessment{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *contexto=[appDelegate managedObjectContext];
    Assessment *sample = [[AssessmentBC current] createAssessment];
    [sample setName:NSLocalizedString(@"Sample Player",@"Sample player name")];
    [sample setBirthday:[[NSDate alloc] init]];
    [sample setSex:@"M"];
    [sample setAssessor:NSLocalizedString(@"My Coach",@"Sample coach name")];
    [sample setDate:[[NSDate alloc] init]];
    [sample setVenue:NSLocalizedString(@"Sample venue",@"Sample venue")];
    
    [sample setMobility:[NSNumber numberWithInt:75]];
    
    for (Stroke *s in [sample strokes]) {
        [s setScore:[NSNumber numberWithInt:2]];
    }
    
    NSError *error;
    [contexto save:&error];
    
    if(error){
        NSLog(@"Erro ao salvar: %@",error);
    }
    
}

- (void) removeAssessment:(Assessment *)object{
    [[object managedObjectContext] deleteObject:object];
    NSError *error;
    [[object managedObjectContext] save:&error];
    
    if(error){
        NSLog(@"Erro ao excluir: %@",error);
    }
    [self setCtx:[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]];
}

@end
