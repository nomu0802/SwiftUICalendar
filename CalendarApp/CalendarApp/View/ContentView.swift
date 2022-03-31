import SwiftUI

struct ContentView: View {
    @State var monthCnt = 0
    let itemPadding: CGFloat = 20
    @GestureState private var dragOffset: CGFloat = 0
    @State var opacity: Double = 1
    @State private var currentIndex = 0
    var body: some View {
        GeometryReader{ bodyView in
              
            VStack{
          
                // カルーセル対象のView
                CalendarViewController(monthCnt: .constant(monthCnt))
                   
                    .frame(width: bodyView.size.width * 0.8, height: 600)
                    .background(Color.gray)
                
             }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .offset(x: self.dragOffset)
                       // currentIndexに応じたoffsetへ移動する
                       .offset(x: -CGFloat(self.currentIndex) * (bodyView.size.width * 0.8 + itemPadding))
                       .gesture(
                           DragGesture()
                            .onChanged({ value in
                                withAnimation() {
                                    self.opacity = 0.5
                                 
                                                   }
                                
                                
                            })
                                    
                                
                  
                           
                               .updating(self.$dragOffset, body: { (value, state, _) in
                                   // 移動幅（width）のみ更新する
                                   state = value.translation.width
                          
                               })
                               .onEnded({ value in
                                   var newIndex = self.currentIndex
                              
                               
                           
                                   //右にスワイプすると１左だと-1
                                    newIndex = value.translation.width > 0 ? self.currentIndex - 1 : self.currentIndex + 1
                                   if(newIndex == 1){
                                       
                                       monthCnt -= 1
                                   }else{
                                       monthCnt += 1
                                   }
                                
                                   //アニメーション　フェードアウトする
                                   withAnimation() {
                                       self.opacity = 1
                                    
                                                      }
                                 
                                 
                               
                                    
                                   
                                   
                               })
                    
                       )
      
                   
                }
        .opacity(self.opacity)
     
        
         }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
