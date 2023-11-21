
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = PageController()
    
    var sec_1 = [Page.home, Page.profile]
    var sec_2 = [Page.settings, Page.help]
    var sec_1_page_1 = ["hello","nive"]
    var sec_2_page_2 = ["asd","help"]
    
    
    var body: some View {
        
        NavigationView {
            List(selection: $viewModel.currentPage) {
                Section(header: Text("Introduction")) {
                    ForEach(sec_1.indices, id: \.self) { pageIndex in
                        if pageIndex < sec_1_page_1.count {
                            let page = sec_1[pageIndex]
                            let title = sec_1_page_1[pageIndex]
                            
                            NavigationLink(
                                destination: mainView(viewModel: viewModel, title: title.lowercased()),
                                tag: page,
                                selection: $viewModel.currentPage,
                                label: {
                                    Label(page.rawValue, systemImage: page.systemImageName())
                                }
                            )
                        }
                    }
                }
                
                Section(header: Text("Experiment")) {
                    ForEach(sec_2.indices, id: \.self) { pageIndex in
                        if pageIndex < sec_2_page_2.count {
                            let page = sec_2[pageIndex]
                            let title = sec_2_page_2[pageIndex]
                            
                            NavigationLink(
                                destination: mainView(viewModel: viewModel, title: title.lowercased()),
                                tag: page,
                                selection: $viewModel.currentPage,
                                label: {
                                    Label(page.rawValue, systemImage: page.systemImageName())
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

struct mainView: View {
    @ObservedObject var viewModel: PageController
    var title: String = ""
    var body: some View {
        VStack {
            Text(title)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
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
                    
                    Text("P1: Getting Started")
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
        ContentView()
    }
}
