//
//  SettingView.swift
//  WWDC
//
//  Created by 蔡俊志 on 2024/2/4.
//

import SwiftUI

enum best_ratio: Float {
    case x1 = 0.2
    case x2 = 0.3
    case x3 = 0.4
}

struct SettingView: View {
    
    
    // 10 -> 20
    @ObservedObject var content_ctrl: PageContentController
    let scene:GameScene
    var body: some View {
        

        VStack {
            VStack(alignment: .leading) {
                HStack{
                    Image(systemName: "hammer.fill")
                    VStack(alignment:.leading){
                        Text("Experiment")
                            .fontWeight(.bold)
                        Text("Settings page")
                            .font(.title3)
                           
                    }
                    
                }
                .foregroundColor(.pink)
                .font(.title)
                
                
                    Button(action: {
                        
                        withAnimation(){
                            self.content_ctrl.isOnSetting = false
                        }
                        self.content_ctrl.done_setting()                        
                        
                    }){
                        HStack{
                            Text("🔨 Start Your Experiment!")
                            Image(systemName: "chevron.right")
                        }.padding()
                            .fontWeight(.bold)
                        
                        
                    }.padding(3)
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    
                    .mask(RoundedRectangle(cornerRadius: 5))
                    
                
                
                ScrollView(showsIndicators: true){
                
                
                    HStack(spacing: 1){
                        
                        Text("Bird & Game settings")
                            .font(.title3)
                            
                            .padding(2)
                            .foregroundColor(.indigo)
                        Spacer()
                    }
                    VStack{
                            Slider(value: Binding<Double>(
                                get: { Double(self.content_ctrl.ui_bird_number) },
                                set: { self.content_ctrl.ui_bird_number = Int($0) }
                            ), in: 12...45, step: 1) {
                            
                                Text("Bird numbers: \(self.content_ctrl.ui_bird_number)")
                                    .fontWeight(.heavy)
                                    
                            }minimumValueLabel: {
                                Text("12")
                            } maximumValueLabel: {
                                Text("45")
                                
                            }
                            Text("In each round, the genes of the bird that flies the furthest will be selected from these birds.")
                                .font(.footnote)
                            Divider()
                        
                            Slider(value: Binding<Double>(
                                get: { Double(self.content_ctrl.ui_bird_brain_size) },
                                set: { self.content_ctrl.ui_bird_brain_size = Int($0) }
                            ), in: 8...48, step: 2) {
                            
                                Text("Bird Brain Volumn:\n \(self.content_ctrl.ui_bird_brain_size) (Neurons)")
                                    .fontWeight(.heavy)
                                    
                            }minimumValueLabel: {
                                Text("Small")
                            } maximumValueLabel: {
                                Text("Large")
                                
                            }
                            Text("The size of the bird, the smaller the bird, the less likely the bird is to hit the column when flying through it.")
                                .font(.footnote)
                        
                            Divider()
                        
                            Slider(value: Binding<Double>(
                                get: { Double(self.content_ctrl.ui_col_gap) },
                                set: { self.content_ctrl.ui_col_gap = Float($0) }
                            ), in: 0...20, step: 1) {
                            
                                Text("Column Gap Size")
                                    .fontWeight(.heavy)
                                    
                            }minimumValueLabel: {
                                Text("Small")
                            } maximumValueLabel: {
                                Text("Large")
                                
                            }
                            Text("This value controls the size of the spacing between the upper and lower columns; the larger the spacing, the easier it is for the bird to fly past. This value must be larger than the size of the bird")
                                .font(.footnote)
                        
                            
                            
                        }
                    HStack(spacing: 1){
                       
                        Text("Genetic Algotithm settings")
                            .font(.title3)
                           
                            .padding(2)
                            .foregroundColor(.indigo)
                        Spacer()
                    }
                    
                    Picker("Best birds selected each round:", selection: Binding(
                        get: { self.content_ctrl.ui_selected_best_ratio },
                        set: { self.content_ctrl.ui_selected_best_ratio = $0 }
                    )) {
                        Text("\(Int(Float(self.content_ctrl.ui_bird_number) * 0.2)) bird").tag(best_ratio.x1)
                        Text("\(Int(Float(self.content_ctrl.ui_bird_number) * 0.3)) bird").tag(best_ratio.x2)
                        Text("\(Int(Float(self.content_ctrl.ui_bird_number) * 0.4)) bird").tag(best_ratio.x3)
                    }
                    .fontWeight(.heavy)
                    .pickerStyle(.segmented)
                    Text("In each round, the genes of the bird that flies the furthest will be selected from these birds.")
                        .font(.footnote)
                
                    
                    Divider()
                    
                    // gene mutation

                    Slider(value: Binding<Double>(
                        get: { Double(self.content_ctrl.ui_mutate_proab) },
                        set: { self.content_ctrl.ui_mutate_proab = Float($0) }
                    ), in: 0...1, step: 0.05)
                    {
                        
                        Text("Genetic mutation\n Probability: \(self.content_ctrl.ui_mutate_proab, specifier: "%.2f")")
                            .fontWeight(.heavy)
                            
                                
                    }minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("1")
                        
                    }
                    
                    Text("Probability of introducing a mutant gene at normal reproduction after each round of simulation in birds.")
                        .font(.footnote)
                    
                    }
                    
            }
        }.padding()
            .frame(width: content_ctrl.size.width*1/2,
                   height: content_ctrl.size.height)
            
    }
}

