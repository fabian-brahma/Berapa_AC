//
//  ContentView.swift
//  Berapa_AC
//
//  Created by Fabian Brahma on 27/04/22.
//

import Combine
import SwiftUI
import UIKit

class Calculate {
    
    var didChange = PassthroughSubject<Void, Never>()
    var indexRuang = 0 { didSet { update()}}
    
    func update() {
        didChange.send(())
        
    }
}

extension Font {
    static func system(
        scaledSize size: CGFloat,
        weight: Font.Weight = .heavy,
        design: Font.Design = .rounded
    ) -> Font {
        Font.system(
            size: UIFontMetrics.default.scaledValue(for: size),
            weight: weight,
            design: design
        )
    }
}




struct ContentView: View {
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
                    navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemOrange]
                    navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.systemOrange]
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.systemOrange], for: .selected)
//        UISegmentedControl.appearance().setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 18),], for: .normal)
        UITableView.appearance().backgroundColor = UIColor.clear
        
        UITableView.appearance().sectionFooterHeight = 2
        
        
        
//        UISegmentedControl.appearance().backgroundColor = .white
    }
    
    @State private var test = ""
    @State private var panjang = ""
    @State private var lebar = ""
    @State private var tinggi = ""
    @State private var noPanjang:Float = 0
    @State private var noLebar:Float = 0
    @State private var noTinggi:Float = 0
    
    @State private var tinggiJendela = ""
    @State private var lebarJendela = ""
    @State private var jumlahJendela = 0
    @State private var noTinggiJendela:Float = 0
    @State private var noLebarJendela:Float = 0
    @State private var noLuasJendela:Float = 0
    @State private var noJumlahJendela:Float = 0
    
    
    @FocusState private var testIsFocused: Bool
    @FocusState private var focusedInput: Field?
    
    @State private var isExpanded = false
    @State private var ruangIndex: JenisRuang?
    @State private var noRuang:Float = 0
    
    @State private var kotaIndex: NamaKota?
    
    @State private var dindingIndex: JenisDinding?
    
    @State private var jumlahDindingIndex: DindingExternal?
    
    
    
    @State private var isShowResult = false
    @State private var isShowCalc = true
    
    
    
    @State var namaKota = [
        NamaKota(name: "Surabaya", deltaT: 4, kotaImage: "surabaya"),
        NamaKota(name: "Jakarta", deltaT: 3.4, kotaImage: "jakarta"),
        NamaKota(name: "Bandung", deltaT: 1, kotaImage: "bandung"),
        NamaKota(name: "Yogyakarta", deltaT: 2.4, kotaImage: "yogya"),
    ]
    
    @State var jenisRuang = [
        JenisRuang(name: "Bedroom", internalHG: 390, ruangImage: "bedroom"),
        JenisRuang(name: "Living Room", internalHG: 690, ruangImage: "livingroom"),
        JenisRuang(name: "Working Room", internalHG: 515, ruangImage: "workroom"),
    ]
    
    @State var jenisDinding = [
        JenisDinding(name: "Bata 150 mm", dindingUValue: 2.36, dindingImage: "bata"),
        JenisDinding(name: "Batako 150 mm", dindingUValue: 1.81, dindingImage: "batako"),
        JenisDinding(name: "Beton 150 mm", dindingUValue: 3.32, dindingImage: "beton"),
    ]
    
    @State var dindingEksternal = [
        DindingExternal(name: "1 Sisi", jumlahDinding: 1, eksImage: "eks 1"),
        DindingExternal(name: "2 Sisi", jumlahDinding: 2, eksImage: "eks 2"),
        DindingExternal(name: "3 Sisi", jumlahDinding: 3, eksImage: "eks 3"),
        DindingExternal(name: "4 Sisi", jumlahDinding: 4, eksImage: "eks 4"),
    ]
    
    enum Field: Int, Hashable, CaseIterable {
        case panjang
        case lebar
        case tinggi
        case tinggiJendela
        case lebarJendela
    }
    
    var hasReachedEnd: Bool {
        self.focusedInput == Field.allCases.last
    }
    
    func next() {
        guard let currentInput = focusedInput,
              let lastIndex = Field.allCases.last?.rawValue else { return }
                
        let index = min(currentInput.rawValue + 1, lastIndex)
        self.focusedInput = Field(rawValue: index)
                  
    }
    
    var disableForm: Bool {
        tinggiJendela.isEmpty || lebarJendela.isEmpty || panjang.isEmpty || lebar.isEmpty || tinggi.isEmpty || ((kotaIndex?.kotaImage) == nil) ||
            ((ruangIndex?.ruangImage) == nil) ||
            ((dindingIndex?.dindingImage) == nil) ||
            ((jumlahDindingIndex?.eksImage) == nil)
    }
    
    var body: some View {
        
        
        NavigationView {
            ScrollViewReader { p in
            Form {
                Section(header: Text("")){
                    
                    HStack{
                    Text("1. LOKASI BANGUNAN")
                            .font(.system(.subheadline, design: .rounded))
                            .fontWeight(.heavy)
                            .foregroundColor(Color.orange)
                        
                        
                        Spacer()
                        
                        Menu {
                            Text("Di kota apa bangunan anda berada?")
                        } label: {
                            Label("", systemImage: "info.circle")
                                .labelStyle(.iconOnly)
                                .frame(width: 15, height: 15)
                                .foregroundColor(Color.orange)
                        }
                    }
                    
                    
                    
//                    TabView{
//                        Image("jawa")
//                            .resizable()
//                            .padding([.trailing, .leading], -8)
//                            .aspectRatio(contentMode: .fit)
//
//                        Image("surabaya")
//                            .resizable()
//                            .padding([.trailing, .leading], -8)
//                            .aspectRatio(contentMode: .fit)
//
//                        Image("jakarta")
//                            .resizable()
//                            .padding([.trailing, .leading], -8)
//                            .aspectRatio(contentMode: .fit)
//
//                    }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//                        .frame(width: 320, height: 115)
                    
//                    Text("\( (kotaIndex?.deltaT ?? 0))")
                    
                    Image("\( (kotaIndex?.kotaImage ?? "jawa"))")
                        .resizable()
                        .padding([.trailing, .leading], -8)
                        .aspectRatio(contentMode: .fit)
                        .transition(.slide)
                        .animation(.easeInOut, value: kotaIndex?.kotaImage)
                        
                        
                    
                    Picker(selection: $kotaIndex, label: Text("Kota")) {
                        ForEach(namaKota) { kota in
                            Text(kota.name).tag(kota as NamaKota?)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                        .padding(-10)
                    
                }.id(150)

                
                
                
                Section(){
                    
                    
                    Text("2. JENIS RUANG")
                        .font(.system(.subheadline, design: .rounded))
                        .fontWeight(.heavy)
                        .foregroundColor(Color.orange)

                    Image("\( (ruangIndex?.ruangImage ?? "emptyroom"))")
                        .resizable()
                        .padding([.trailing, .leading], -8)
                        .aspectRatio(contentMode: .fit)
                    
                    Picker(selection: $ruangIndex, label: Text("Ruangan")) {
                        ForEach(jenisRuang) { ruang in
                            Text(ruang.name).tag(ruang as JenisRuang?)
                        }
                }.pickerStyle(SegmentedPickerStyle())
                        .padding(-10)

//                    Text("\((2 * 12.5 ) * (ruangIndex?.internalHG ?? -10))")
                    }
                
                Section(){
                    Text("3. DIMENSI RUANG")
                        .font(.system(.subheadline, design: .rounded))
                        .fontWeight(.heavy)
                        .foregroundColor(Color.orange)

                    
                    
                    
                    TextField("Panjang (m)", text: $panjang)
                        .keyboardType(.decimalPad)
                        .focused($focusedInput, equals: .panjang)
                    TextField("Lebar (m)", text: $lebar)
                        .keyboardType(.decimalPad)
                        .focused($focusedInput, equals: .lebar)
                    TextField("Tinggi (m)", text: $tinggi)
                        .keyboardType(.decimalPad)
                        .focused($focusedInput, equals: .tinggi)

//                    Button("Submit") {
//                                    noPanjang = Float(panjang) ?? 0
//                                    print("Panjang: \(panjang)")
//                                    noLebar = Float(lebar) ?? 0
//                                    print("Lebar: \(lebar)")
//                                    noTinggi = Float(tinggi) ?? 0
//                                    print("Tinggi: \(tinggi)")
//                                    hideKeyboard()
//
//                    }.padding(10)
//                        .frame(maxWidth: .infinity)
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
//                        .listRowBackground(Color.blue)
                    
                }
                
                Section(){
                    HStack{
                        Text("4. LUAS JENDELA")
                            .font(.system(.subheadline, design: .rounded))
                            .fontWeight(.heavy)
                            .foregroundColor(Color.orange)
                        
                        Spacer()
                        
                        Menu {
                            Text("Ukuran jendela yang digunakan dalam ruangan")
                        } label: {
                            Label("", systemImage: "info.circle")
                                .labelStyle(.iconOnly)
                                .frame(width: 15, height: 15)
                                .foregroundColor(Color.orange)
                        }
                    }

                    
                    TextField("Tinggi Jendela (m)", text: $tinggiJendela)
                        .keyboardType(.decimalPad)
                        .focused($focusedInput, equals: .tinggiJendela)

                    TextField("Lebar Jendela (m)", text: $lebarJendela)
                        .keyboardType(.decimalPad)
                        .focused($focusedInput, equals: .lebarJendela)

                    Stepper(value: $jumlahJendela, in: 0...10){
                        Text("Jumlah Jendela: \(jumlahJendela)")
                    
                    }
                }
                
                Section(){
                    Text("5. JENIS DINDING")
                        .font(.system(.subheadline, design: .rounded))
                        .fontWeight(.heavy)
                        .foregroundColor(Color.orange)
                    
                    Image("\( (dindingIndex?.dindingImage ?? "bata"))")
                        .resizable()
                        .padding([.trailing, .leading], -8)
                        .aspectRatio(contentMode: .fit)
                    
                    Picker(selection: $dindingIndex, label: Text("Jenis Dinding")) {
                        ForEach(jenisDinding) { dinding in
                            Text(dinding.name).tag(dinding as JenisDinding?)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                        .padding(-10)
            }
                
                Section(){
                    HStack {
                        Text("6. JUMLAH DINDING EKSTERNAL")
                            .font(.system(.subheadline, design: .rounded))
                            .fontWeight(.heavy)
                            .foregroundColor(Color.orange)
                        
                        Spacer()
                        
                        Menu {
                            Text("Jumlah dinding yang langsung terkena matahari")
                        } label: {
                            Label("", systemImage: "info.circle")
                                .labelStyle(.iconOnly)
                                .frame(width: 15, height: 15)
                                .foregroundColor(Color.orange)
                        }
                    }
                    
                    Image("\( (jumlahDindingIndex?.eksImage ?? "eks 0"))")
                        .resizable()
                        .padding([.trailing, .leading], -8)
                        .aspectRatio(contentMode: .fit)
                    
                    Picker(selection: $jumlahDindingIndex, label: Text("")) {
                        ForEach(dindingEksternal) { dindingeks in
                            Text(dindingeks.name).tag(dindingeks as DindingExternal?)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                        .padding(-10)
            }
                
                Section{
                if isShowResult {
                    
                    let intNoLuasJendela: Int = Int(noLuasJendela)
                    
                    ZStack{
                    Rectangle()
                        .fill(.red)
                        .frame(height: 0)
                        VStack{
                            Text("AC yang dibutuhkan")
                                .padding([.top, .bottom], 10)
                                .font(.system(size: 15, weight: .semibold, design: .default))
                            Rectangle()
                                .fill(.quaternary)
                                .frame(height: 1)
                        HStack{
                            VStack{
                                Spacer()
                                Text("\(intNoLuasJendela)")
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 9, trailing: 0))
                                .font(.system(size: 60, weight: .black, design: .default))
                                .foregroundColor(Color.orange)
                                
                            }
                            VStack{
                                Spacer()
                            Text("Unit AC")
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 19, trailing: 0))
                                .font(.system(size: 22, weight: .bold, design: .default))
                                
                                
                            }
                            
                            Spacer()
                            
                            VStack{
                                Spacer()
                            Text("1.5")
                                .padding(EdgeInsets(top: 10, leading: 50, bottom: 15, trailing: 0))
                                .font(.system(size: 30, weight: .black, design: .default))
                                .foregroundColor(Color.orange)
                                
                            }
                            VStack{
                                Spacer()
                            Text("PK")
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 18, trailing: 0))
                                .font(.system(size: 20, weight: .bold, design: .default))
                                
                            }
                            
                                
                        Spacer()
                            }
                        }
                    }
                    
                }
                    
                    }
                
                if isShowCalc {
                    
                    
                    
                Button("Calculate") {
                    noTinggiJendela = Float(tinggiJendela) ?? 0
                    noLebarJendela = Float(lebarJendela) ?? 0
                    noJumlahJendela = Float(jumlahJendela)
            
                    noLuasJendela = (noTinggiJendela) * (noLebarJendela) * (noJumlahJendela)
                    
                    withAnimation {
                    isShowResult.toggle()
                    }
                    
                    withAnimation {
                    isShowCalc.toggle()
                    }
            
                    print(noLuasJendela)
                    print((kotaIndex?.deltaT ?? 0) + (noLuasJendela))
                    
                }.padding(10)
                .disabled(disableForm)
                .frame(maxWidth: .infinity)
                .background((disableForm) ? Color.clear : Color.orange)
                .foregroundColor(.white)
                .listRowBackground((disableForm) ? Color.secondary : Color.orange)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                }
                
                
                
                Section{
                    
                if isShowResult {
                    
                    Button("New Calculation") {
                        
                        panjang = ""
                        lebar = ""
                        tinggi = ""
                        
                        tinggiJendela = ""
                        lebarJendela = ""
                        jumlahJendela = 0
                        
                        withAnimation {
                        isShowResult.toggle()
                        }
                        
                        withAnimation {
                        isShowCalc.toggle()
                        }
                        
                        withAnimation {
                        p.scrollTo(150)
                        }
                        
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.orange)
                    }
                }.overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.orange, lineWidth: 0.4)
                )
            
                
            } // Form
            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 6, y: 3)
            .navigationTitle("ACount")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
//                        testIsFocused = false
                        if hasReachedEnd == false {
                            next()
                        } else {
                            focusedInput = nil
                        }
                    }.foregroundColor(Color.orange)
                }
            }
            
        } // ScrollviewReader
            
    }

}
        
        
        
        }

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif






//TextField("jumlah", text: $Portion)
//                                    .onChange(of: Portion, perform: {newValue in
//                                        let filtered = newValue.filter { $0.isNumber }
//
//                                        if newValue != filtered {
//                                            Portion = filtered
//                                        }
//                                    })
//
//                                    .textFieldStyle(.plain)
//                                    .foregroundColor(Color.black)
//                                    .font(.custom("GloriaHallelujah", size: 17))
//                                    .multilineTextAlignment(.leading)
//                                    .keyboardType(.decimalPad)

















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
