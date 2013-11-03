//
//  GCDatabase.h
//  GCDatabase

// https://github.com/enormego/egodatabase

/*
    MODO DE USAR:
 
 Em AppDelegate.m
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    // Esta função irá copiar o banco de dados para área editável e deixar tudo preparado. 
    if (![GCDatabase loadDatabase:@"NomeDoDB" ofType:@"sqlite" aliasKeyPath:@"ApelidoDoDB"]) {
        GCLog(@"Não foi possível salvar banco de dados.");
    }
 }
 
 Em classes que queiram acesso ao DB
 
 { // SELECIONAR REGISTRO
    GCDatabase *database = [GCDatabase databaseWithAliasKeyPath:@"ApelidoDoDB"];
    GCDatabaseResult *result = [database executeQuery:@"SELECT * FROM MinhaTabela"];
 
    GCTableSection *section = [GCTableSection section];
    for (GCDatabaseRow *row in result) {
        NSString *minhaString = [row stringForColumn:@"nomeCampoString"];
        int menuInteger       = [row intForColumn:@"nomeCampoInteger"];
    }

 }
 
 { // REMOVER REGISTRO
    GCDatabase *database = [GCDatabase databaseWithAliasKeyPath:@"ApelidoDoDB"];
 
    NSString *query = [NSString stringWithFormat:@"DELETE FROM MinhaTabela WHERE idRow = %@", @"1" ];
    GCDatabaseResult *result = [database executeQuery:query];
 
    if (result.errorCode != 0) {
        GCLog(@"Não foi possível remover registro");
    } else {
        GCLog(@"Registro removido com sucesso");
    }
 }
 
 { // ADICIONAR NOVO REGISTRO
    GCDatabase *database = [GCDatabase databaseWithAliasKeyPath:@"ApelidoDoDB"];
 
    NSString *query = [NSString stringWithFormat:@"INSERT INTO MinhaTabela (campo1, campo2) VALUES ('%@', '%@')", 
                        valorCampo1, valorCampo2,];
 
    GCDatabaseResult *result = [database executeQuery:query];
    if (result.errorCode != 0) {
        GCLog(@"Não foi possível adicionar registro");
    } else {
        GCLog(@"Registro adicionado com sucesso");
    }
 }
 
*/ 

#import <Foundation/Foundation.h>
#import <sqlite3.h>

#import "GCDatabaseRequest.h"
#import "GCDatabaseResult.h"
#import "GCDatabaseRow.h"

@interface GCDatabase : NSObject {
@protected
	NSString* databasePath;
	NSLock* executeLock;
	
@private
	sqlite3* handle;
	BOOL opened;
}

+ (id)databaseWithPath:(NSString*)aPath;
+ (id)databaseWithAliasKeyPath:(NSString*)aliasKeyPath;
- (id)initWithPath:(NSString*)aPath;

+(BOOL)loadDatabase:(NSString *)database ofType:(NSString *)type aliasKeyPath:(NSString *)aliasKeyPath;

- (BOOL)open;
- (void)close;

// Execute Updates
- (BOOL)executeUpdateWithParameters:(NSString*)sql, ... NS_REQUIRES_NIL_TERMINATION;

- (BOOL)executeUpdate:(NSString*)sql;
- (BOOL)executeUpdate:(NSString*)sql parameters:(NSArray*)parameters;

// Execute Query
- (GCDatabaseResult*)executeQueryWithParameters:(NSString*)sql, ... NS_REQUIRES_NIL_TERMINATION;

- (GCDatabaseResult*)executeQuery:(NSString*)sql;
- (GCDatabaseResult*)executeQuery:(NSString*)sql parameters:(NSArray*)parameters;

// Query request operation

- (GCDatabaseRequest*)requestWithQueryAndParameters:(NSString*)sql, ... NS_REQUIRES_NIL_TERMINATION;

- (GCDatabaseRequest*)requestWithQuery:(NSString*)sql;
- (GCDatabaseRequest*)requestWithQuery:(NSString*)sql parameters:(NSArray*)parameters;

// Update request operation

- (GCDatabaseRequest*)requestWithUpdateAndParameters:(NSString*)sql, ... NS_REQUIRES_NIL_TERMINATION;

- (GCDatabaseRequest*)requestWithUpdate:(NSString*)sql;
- (GCDatabaseRequest*)requestWithUpdate:(NSString*)sql parameters:(NSArray*)parameters;

- (sqlite3_int64)last_insert_rowid;

// Error methods

- (NSString*)lastErrorMessage;
- (BOOL)hadError;
- (int)lastErrorCode;

@property(nonatomic,readonly) sqlite3* sqliteHandle;
@end
