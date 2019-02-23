//
//  RWTViewController.m
//  GunnerTheRunner
//
//  Created by Gagandeep Heer on 2019-02-16.
//

#import "RWTViewController.h"
#import "RWTVertex.h"
#import "RWTBaseEffect.h"
#import "RWTGlock.h"

@interface RWTViewController ()

@end

@implementation RWTViewController {
    RWTBaseEffect *_shader;
    RWTGlock *_glock;
}

- (void)setupScene {
    _shader = [[RWTBaseEffect alloc] initWithVertexShader:@"RWTSimpleVertex.glsl" fragmentShader:@"RWTSimpleFragment.glsl"];
    _glock = [[RWTGlock alloc] initWithShader:_shader];
    //_cube = [[RWTCube alloc] initWithShader:_shader];
    _shader.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(85.0), self.view.bounds.size.width / self.view.bounds.size.height, 1, 150);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    GLKView *view = (GLKView *)self.view;
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    view.drawableDepthFormat = GLKViewDrawableDepthFormat16;
    
    [EAGLContext setCurrentContext:view.context];
    
    [self setupScene];
    
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    GLKMatrix4 viewMatrix = GLKMatrix4MakeTranslation(0, -1, -5);
    viewMatrix = GLKMatrix4Rotate(viewMatrix, GLKMathDegreesToRadians(20), 1, 0, 0);
    
    [_glock renderWithParentModelViewMatrix:viewMatrix];
    //[_cube renderWithParentModelViewMatrix:viewMatrix];
    
}

- (void)update {
    [_glock updateWithDelta:self.timeSinceLastUpdate];
    //[_cube updateWithDelta:self.timeSinceLastUpdate];
}

@end
