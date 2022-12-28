//
//  ContentView.swift
//  Devote
//
//  Created by Vijay Parmar on 15/07/22.
//

import SwiftUI
import CoreData
import UIKit
struct ContentView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State var task: String = ""
    @State private var showNewItem: Bool = false
    //Fetching Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    init(){
          UITableView.appearance().backgroundColor = UIColor(Color.clear)
      }
    

    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    
    var body: some View {
        NavigationView {
            ZStack {
                //MARK: - Main view
                VStack{
                    //MARK: - Header
                    HStack(spacing:10){
                        //Title
                        Text("Devote")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading,4)
                        Spacer()
                        //Edit Button
                         EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal,10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(
                                Capsule().stroke(Color.white,lineWidth: 2)
                            )
                        
                        //Apperiance Button
                        Button(action: {
                            isDarkMode.toggle()
                            playSound(sound: "sound-rise", type: "mp3")
                        }, label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                            
                        })
                    }
                    .padding()
                    .foregroundColor(.white)
                
                    Spacer(minLength: 80)
                    //MARK: - New Task Button
                    Button(action:{
                        showNewItem=true
                        playSound(sound: "sound-ding", type: "mp3")
                    },label:{
                       
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30,weight: .bold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24,weight: .bold, design: .rounded))
                    }
                    )
                    .foregroundColor(.white)
                    .padding(.horizontal,20)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.pink,.blue]), startPoint: .leading, endPoint: .trailing).clipShape(Capsule())
                    
                    )
                    .shadow(color: Color(red:0,green: 0,blue: 0,opacity: 0.25), radius: 8)
                    
                    
                    //MARK: - Tasks
                    List {
                        ForEach(items) { item in
                            
                           ListRowItemView(item: item)
                        }
                        .onDelete(perform: deleteItems)
                    }//List
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red:0,green: 0,blue: 0,opacity: 0.3), radius: 10,x: 0,y: 0)
                    .padding(.vertical,0)
                    .frame(maxWidth:640)
                }//Vstack
                .blur(radius: showNewItem ? 8.0 : 0, opaque: false)
                .transition(.move(edge: .bottom))
                .animation(.easeOut(duration: 0.5))
                .onAppear {
                    // Set the default to clear
                    UITableView.appearance().backgroundColor = .clear
                }
                //MARK: - NewTask Item
                if showNewItem{
                    BlankView(backgroundColor: isDarkMode ? Color.black : Color.gray, backgroundOpacity: isDarkMode ? 0.3 : 0.5)
                        .onTapGesture {
                            withAnimation(){
                                showNewItem = false
                            }
                        }
                    NewTaskItemView(isShowing: $showNewItem)
                }
            }//ZStack
            .navigationBarTitle("Daily Task",displayMode:.large)
            .navigationBarHidden(true)
            .background(
            ImageBackgroundView()
                .blur(radius: showNewItem ? 8.0 : 0, opaque: false)
            )
            .background(
                backgroundGradient.ignoresSafeArea(.all)
            )
            
        }// Navigation
        .navigationViewStyle(.stack)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

