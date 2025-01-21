# Simple Synchronous RAM Design

## **Problem Overview**
This design implements a simple single-port synchronous RAM with the following specifications:

### **Memory Parameters**
- **Depth:** 256 locations (addressable using 8-bit addresses)
- **Width:** 32 bits per word
- **Operating Mode:** Synchronous Read/Write
- **Configuration:** Single port

---

## **Interface Signals**

### **Inputs**
| **Signal**   | **Width** | **Description**                                                                 |
|--------------|-----------|---------------------------------------------------------------------------------|
| `clk`        | 1-bit     | System clock. All operations are synchronized to the positive edge of the clock.|
| `rst_n`      | 1-bit     | Active low asynchronous reset. Initializes memory to zero.                     |
| `write_en`   | 1-bit     | Write enable signal. Controls read/write operations.                           |
| `addr`       | 8-bit     | Address input. Specifies the memory location for read/write.                   |
| `data_in`    | 32-bit    | Input data. Data to be written into the specified memory location.             |

### **Output**
| **Signal**   | **Width** | **Description**                                                                 |
|--------------|-----------|---------------------------------------------------------------------------------|
| `data_out`   | 32-bit    | Output data. Data read from the specified memory location.                     |

---

## **Functionality**

### **1. Write Operation**
- Triggered when `write_en = 1`.
- The value on `data_in` is written into the memory location specified by `addr` on the positive edge of the clock.

### **2. Read Operation**
- Triggered when `write_en = 0`.
- The value stored in the memory location specified by `addr` is output on `data_out` on the positive edge of the clock.

### **3. Reset**
- Triggered when `rst_n = 0`.
- All memory locations are cleared (set to 0).
- The output register `data_out` is also reset to 0.

---

## **Key Design Characteristics**
- **Synchronous Operation:** All read/write operations occur on the positive edge of the clock.
- **Asynchronous Reset:** Resetting the memory and output register does not depend on the clock signal.
- **Single-Port Access:** Only one operation (read or write) can occur at a time.

---

## **Design Implementation**
### **Memory Array**
- The memory is implemented as a 2D `reg` array:
  ```Verilog
  reg [31:0] mem [0:255];  // 256 locations, 32 bits each
  
1. Block Diagram: Synchronous RAM
 
![image](https://github.com/user-attachments/assets/61d51d65-2757-4da2-92b6-16a31217313a)

2. Synchronous RAM Interface Signals

![image](https://github.com/user-attachments/assets/7d18e36c-d8b1-4659-8295-d894f4ba21f4)

3. Operation Timing

![image](https://github.com/user-attachments/assets/fa36533a-bc3f-4d3f-a7e0-a23c1388ae0d)

