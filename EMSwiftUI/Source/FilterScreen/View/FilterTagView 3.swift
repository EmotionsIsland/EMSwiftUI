//
//  FilterTagView 3.swift
//  EMSwiftUI
//
//  Created by Home on 09.01.2026.
//


//
//  FilterTagView.swift
//  EMSwiftUI
//

import SwiftUI

struct FilterTagView: View {
    let title: String
    let isSelected: Bool
    let showIcon: Bool
    let action: () -> Void
    
    init(
        title: String,
        isSelected: Bool,
        showIcon: Bool = true,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.isSelected = isSelected
        self.showIcon = showIcon
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if showIcon {
                    Image(systemName: "plus")
                        .font(.system(size: 14, weight: .bold))
                }
                
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .lineLimit(1)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(isSelected ? Color.orangeBase : Color.grayBase)
            .foregroundColor(isSelected ? .white : .black)
            .cornerRadius(8)
            // ← БЕЗ .frame(maxWidth: .infinity) - ширина по контенту!
        }
    }
}
```

---

## **📊 Результат с WrappingHStack:**
```
┌────────┐ ┌──────────────┐ ┌──────┐
│Erotica │ │Pornographic  │ │ Safe │  ← ширина по контенту
└────────┘ └──────────────┘ └──────┘
    12px        12px          12px
      ↓           ↓             ↓
   равномерные отступы

┌──────────┐
│Suggestive│  ← перенеслась на новую строку
└──────────┘