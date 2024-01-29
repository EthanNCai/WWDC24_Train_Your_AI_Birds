
import SwiftUI

struct StageView: View {
    @ObservedObject var viewModel = PageController()
    
    var intro_name = [Page.intro_1_view, Page.profile, Page.new]
    var intro_viewpages = [AnyView(Intro_1_View()),
                        AnyView(Intro_2_View()),
                        AnyView(Intro_2_View())] as [AnyView]
    
    var experiment_name = [Page.settings, Page.help]
    var experiment_viewpages = [AnyView(Intro_3_View()),
                        AnyView(Intro_1_View())] as [AnyView]
    
    
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
                
                
                Section(header: Text("Experiments")) {
                    ForEach(experiment_name.indices, id: \.self) { pageIndex in
                        if pageIndex < experiment_viewpages.count {
                            let page = experiment_name[pageIndex]
                            let view = experiment_viewpages[pageIndex]
                            
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
                            viewModel.currentPage = previousPage
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
                            viewModel.currentPage = nextPage
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
