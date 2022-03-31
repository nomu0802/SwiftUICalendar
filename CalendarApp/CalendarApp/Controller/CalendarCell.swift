
import SwiftUI

struct CalendarCell: View {
    @Binding var dayCell: String
    var body: some View {
        HStack{
            Spacer()
            if(dayCell == "0"){
                Text("")
            }else{
        Text(dayCell)
                
            }
            Spacer()
        }
    }
}

struct CalendarCell_Previews: PreviewProvider {
    static var previews: some View {
        CalendarCell(dayCell: .constant("4"))
    }
}
