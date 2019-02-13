//
//  Contato.h
//  ContatosIP67
//
//  Created by ios8207 on 05/02/19.
//  Copyright © 2019 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MKAnnotation.h>
#import <CoreData/CoreData.h>

@interface Contato : NSManagedObject <MKAnnotation>



@property(strong) NSString *nome;
@property(strong) NSString *telefone;
@property(strong) NSString *endereco;
@property(strong) NSString *site;
@property(strong) UIImage *foto;
@property(strong) NSNumber *latitude;
@property(strong) NSNumber *longitude;




@end
