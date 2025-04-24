# ⚡ Optimal DC Power Flow - MATLAB Implementation

This project solves the **Optimal Power Flow (OPF)** problem using a **DC power flow model** and **linear programming**. The model is implemented in MATLAB and calculates optimal power dispatch, bus voltage angles, and line power flows, subject to system constraints like generator limits and line capacities.

> 📂 Original code repository: [github.com/CayoRw/Optimal_Flow_DC_Cayo](https://github.com/CayoRw/Optimal_Flow_DC_Cayo)

---

## 🧠 Overview

The goal is to minimize the total generation cost while satisfying:

- Power balance at each bus
- Generator upper and lower bounds
- Line flow limits

The system is modeled using a DC approximation of power flow, making the optimization linear and solvable using `linprog`.

---

## 📌 Files Included

| File                  | Description                                           |
|-----------------------|-------------------------------------------------------|
| `main.m`              | Main script to run the OPF analysis                   |
| `ReadData.m`          | Reads system data from a `.txt` file                  |
| `GetBBus.m`           | Builds the susceptance matrix (`Bbus`)               |
| `GetMainDatas.m`      | Extracts system parameters like generation/load data  |
| `LinProgDatas.m`      | Prepares the inputs for the `linprog` solver          |
| `CalcFlow.m`          | Computes power flows on lines using bus angles        |
| `Get_new_DBAR.m`      | Updates bus data with optimal values                  |
| `DispResults.m`       | Displays results in a readable format                 |
| `dados_sistema13B_EC4.txt` | Example data file for a 13-bus system          |

---

## 🛠 How to Run

1. Clone this repository or download the files.
2. Open `main.m` in MATLAB.
3. Make sure the file `dados_sistema13B_EC4.txt` is in the same directory.
4. Run the script:

```matlab
>> main
