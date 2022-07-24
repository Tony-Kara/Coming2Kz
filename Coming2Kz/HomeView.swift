//
//  HomeView.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 22.07.2022.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
      ZStack {
        Color("Background").ignoresSafeArea()
        ScrollView {
          VStack(alignment: .leading, spacing: 0) {
            Text("Courses")
              .customFont(.largeTitle)
              .frame(maxWidth:.infinity, alignment: .leading)
              .padding(.horizontal,20)
            
            ScrollView(.horizontal, showsIndicators: false){
              HStack{
                ForEach(courses) { course in
                  VCard(course: course)
                  
                }
              }
              .padding(20)
              .padding(.bottom,10)
            }
            
              Text("Recent")
              .customFont(.title3)
              .padding(.horizontal,20)
            
            VStack(spacing:20){
              ForEach(courseSections) { section in
                HCard(section: section)
              }
            }
            .padding(20)
          }
        }
      }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
