//
//  GCTabBarController.h
//  GCKit
//
//  Created by Marcelo Queiroz on 25/08/2011
//  Copyright 2011 FingerTips. All rights reserved.
//
//  Func.: Classe responsavel por apresentar e customizar a UITabBar de um UITabBarController
//  ----- Alter History -----
//  Autor - Alter Date (dd/MM/yy) - Log
//

#import <Foundation/Foundation.h>

@protocol GCTabBarControllerDataSource;

@interface GCTabBarController : UITabBarController {
    UIView *_backgroudView;
    NSMutableArray *_tabBarButtons;
    
    id <GCTabBarControllerDataSource> _dataSource;
}
@property (nonatomic, strong) id<GCTabBarControllerDataSource> dataSource;

/**************************************************************************\
 * Func.: Metodo que seleciona o tab bar item.
 * In: Index do tab bar item a ser selecionado.
 * Out: N/A
 \**************************************************************************/
- (void) selectTabBarItemAtIndex: (int)tabBarItemIndex;

@end

/**************************************************************************\
 * Func.: Protocolo responsável por popular a tab bar customizada.
 \**************************************************************************/
@protocol GCTabBarControllerDataSource <NSObject>

@required
/**************************************************************************\
 * Func.: Metodo que recupera o número de botões.
 * In: GCTabBarController que está solicitando o número de botões.
 * Out: NSInteger do número de botões.
 \**************************************************************************/
- (NSInteger)gcTabBarControllerNumberOfTabBarItens:(GCTabBarController *)gcTabBarController;

/**************************************************************************\
 * Func.: Metodo que recupera a imagem do estado normal do botão da 
 * tab bar em um dado index.
 * In: GCTabBarController que está solicitando o tamanho do botão e o index
 * do botão.
 * Out: UIImage do estado normal do botão.
 \**************************************************************************/
- (UIImage*) gcTabBarController: (GCTabBarController*) tabBarController normalImageAtIndex: (NSInteger) index;

/**************************************************************************\
 * Func.: Metodo que recupera a imagem do estado selecionado do botão da 
 * tab bar em um dado index.
 * In: GCTabBarController que está solicitando o tamanho do botão e o index
 * do botão.
 * Out: UIImage do estado selecionado do botão.
 \**************************************************************************/
- (UIImage*) gcTabBarController: (GCTabBarController*) tabBarController selectedImageAtIndex: (NSInteger) index;

/**************************************************************************\
 * Func.: Metodo que recupera o tamanho do botão da tab bar em um dado index.
 * In: GCTabBarController que está solicitando o tamanho do botão e o index
 * do botão.
 * Out: CGSize do botão em questão
 \**************************************************************************/
- (CGSize) gcTabBarController: (GCTabBarController*) tabBarController sizeForButtonAtIndex: (NSInteger) index;

@optional
/**************************************************************************\
 * Func.: Metodo que recupera a cor de fundo da tab bar.
 * In: GCTabBarController que está solicitando a cor de fundo
 * Out: UIColor da cor de fundo
 \**************************************************************************/
- (UIColor*) gcTabBarControllerBackgroundColor: (GCTabBarController *)gcTabBarController;

/**************************************************************************\
 * Func.: Metodo que recupera a imagem de background da tab bar. Essa 
 * imagem irá sobrepor a cor de fundo.
 * In: GCTabBarController que está solicitando essa imagem
 * Out: Imagem de fundo
 \**************************************************************************/
- (UIImage*) gcTabBarControllerBackgroundImage: (GCTabBarController *)gcTabBarController;

@end