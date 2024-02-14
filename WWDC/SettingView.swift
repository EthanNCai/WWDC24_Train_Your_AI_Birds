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
                        
                        Text("Tips")
                            .font(.title3)
                            
                            .padding(2)
                            .foregroundColor(.indigo)
                        Spacer()
                    }
                    Text("The __Neural Network Weights(aka genes)__ of the birds in the __FIRST__ generation of the experiment are __COMPLETELY RANDOM__.")
                    HStack(spacing: 1){
                        
                        Text("Bird & Environment settings")
                            .font(.title3)
                            
                            .padding(2)
                            .foregroundColor(.indigo)
                        Spacer()
                    }
                    
                    
                    VStack(alignment: .leading){
                        
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
                            Text("Larger populations generally have a __higher probability__ of randomly producing the desired __excellent genes__ from the beginning.")
                                .font(.footnote)
                            Divider()
                        
                            Slider(value: Binding<Double>(
                                get: { Double(self.content_ctrl.ui_bird_brain_size) },
                                set: { self.content_ctrl.ui_bird_brain_size = Int($0) }
                            ), in: 8...48, step: 2) {
                            
                                Text("Bird Brain Capacity:\n \(self.content_ctrl.ui_bird_brain_size) (Neurons)")
                                    .fontWeight(.heavy)
                                    
                            }minimumValueLabel: {
                                Text("Small")
                            } maximumValueLabel: {
                                Text("Large")
                                
                            }
                            Text("The length of the __parameter of the neural network__ behind each bird. A higher brain capacity means that birds are capable of __learning more__, but it also implies __longer learning cycles__ and greater __computational costs__.")
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
                            Text("The gap between the two pillars, the __smaller__ this value, the __more difficult__ it is for the bird to pass through, increasing it will reduce the difficulty.")
                                .font(.footnote)
                        
                       
                    
                        Slider(value: Binding<Double>(
                            get: { Double(self.content_ctrl.ui_speed_index) },
                            set: { self.content_ctrl.ui_speed_index = Float($0) }
                        ), in: 0...20, step: 1) {
                        
                            Text("Column Speed")
                                .fontWeight(.heavy)
                                
                        }minimumValueLabel: {
                            Text("Slow")
                        } maximumValueLabel: {
                            Text("Fast")
                            
                        }
                        
                        Text("This is the speed at which the pillars move. __The faster they move__, the quicker the bird's reaction speed needs to be, resulting in a __higher difficulty__. Decreasing the speed will lower the difficulty.")
                            .font(.footnote)
                        
                        //Divider()
                        
                            
                            
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
                    Text("The number of excellent birds selected in each round, __ALL__ birds in the next round will be produced by the mating of __these selected birds.__")
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
                    
                    Text("Genetic mutation introduces randomness, which can bring both benefits and drawbacks. A small probability of mutation is advantageous as it allows for the random generation of excellent genes.")
                        .font(.footnote)
                    
                    }
                    
            }
        }.padding()
            .frame(width: content_ctrl.size.width*1/2,
                   height: content_ctrl.size.height)
            
    }
}

