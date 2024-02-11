
import SwiftUI

struct StageView: View {
    @ObservedObject var viewModel = PageController()
    
    var intro_name = [Page.introduction_page, Page.flappybird_page]
    var intro_viewpages = [AnyView(IntroductionPage()),
                           AnyView(FlappyBirdPage())] as [AnyView]
    
    
    
    var knowledges_names = [Page.neural_network_page, Page.ga_page]
    var knowledges_viewmaps = [AnyView(NeuralNetworkPage()),
                        AnyView(GAPage())] as [AnyView]
    
    var experiment_names = [Page.experiment_page]
    var experiment_viewmaps = [
                        AnyView(ExperimentPage())] as [AnyView]
    
    
    
    
    var body: some View {
        NavigationView {
            List(selection: $viewModel.currentPage) {
                Section(header: Text("Introduction")) {
                    ForEach(intro_name.indices, id: \.self) { pageIndex in
                        if pageIndex < intro_viewpages.count {
                            let page = intro_name[pageIndex]
                            let view = intro_viewpages[pageIndex]
                            NavigationLink(
                                destination: StageContentView(viewModel: viewModel, view: view,title: page.pageTitle()),
                                tag: page,
                                selection: $viewModel.currentPage,
                                label: {
                                    Label(page.rawValue, systemImage: page.PageIconFile())
                                }
                                
                            )
                        }
                    }
                }
                
                
                Section(header: Text("Core knowledge")) {
                    ForEach(knowledges_names.indices, id: \.self) { pageIndex in
                        if pageIndex < knowledges_viewmaps.count {
                            let page = knowledges_names[pageIndex]
                            let view = knowledges_viewmaps[pageIndex]
                            
                            NavigationLink(
                                destination: StageContentView(viewModel: viewModel, view: view,title: page.pageTitle()),
                                tag: page,
                                selection: $viewModel.currentPage,
                                label: {
                                    Label(page.rawValue, systemImage: page.PageIconFile())
                                }
                            )
                        }
                    }
                }
                
                Section(header: Text("Experiment")) {
                    ForEach(experiment_names.indices, id: \.self) { pageIndex in
                        if pageIndex < experiment_viewmaps.count {
                            let page = experiment_names[pageIndex]
                            let view = experiment_viewmaps[pageIndex]
                            
                            NavigationLink(
                                destination: StageContentView(viewModel: viewModel, view: view,title: page.pageTitle()),
                                tag: page,
                                selection: $viewModel.currentPage,
                                label: {
                                    Label(page.rawValue, systemImage: page.PageIconFile())
                                }
                            )
                        }
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 200)
        }
    }
}

struct StageContentView<Content: View>: View {
    @ObservedObject var viewModel: PageController
    var view: Content
    var title: String
    var body: some View {
        VStack {
                view.frame(maxWidth: .infinity, maxHeight: .infinity)
                
            HStack {
                
                HStack{
                    Button(action: {
                        if let previousPage = viewModel.currentPage?.previous() {
                            withAnimation(){
                                viewModel.currentPage = previousPage
                            }
                        }
                    }) {
                        HStack
                        {
                            Image(systemName: "arrow.left")
                                .fontWeight(.black)
                            Text("Previous Page")
                        }
                    }
                    .disabled(viewModel.currentPage?.isFirstPage() ?? true)
                    
                    Text(title)
                        .padding()

                    Button(action: {
                        if let nextPage = viewModel.currentPage?.next() {
                            withAnimation(){
                                viewModel.currentPage = nextPage
                            }
                            
                        }
                    }) {
                        HStack
                        {
                            Text("Next Page")
                            Image(systemName: "arrow.right")
                                .foregroundColor(.blue)
                                .fontWeight(.black)
                        }
                        
                    }
                    .disabled(viewModel.currentPage?.isLastPage() ?? true)
                }
                .padding(.horizontal)
            }
            .font(.headline)
            .padding()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StageView()
    }
}
