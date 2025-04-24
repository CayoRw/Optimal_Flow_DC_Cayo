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

## 🚀 How to Run

1. Clone or download this repository.
2. Open `main.m` in MATLAB.
3. Ensure the input file `dados_sistema13B_EC4.txt` is in the same folder.
4. Run the script:

```matlab
>> main
```

---

## ✏️ Customizing Your System

You can **run the optimal power flow on your own system** by modifying the `.txt` input file.

The input file defines:

- **Bus data** (loads, generation, type of bus)
- **Line data** (connections between buses, limits)

Simply replace the contents of `dados_sistema13B_EC4.txt` with your system’s configuration.  
The model will automatically adapt and solve your customized OPF problem!

✅ No need to change the MATLAB code — just edit the `.txt` file to match your system!

---

## 📈 Outputs

- Optimal generator dispatch
- Bus voltage angles (in radians)
- Power flows in transmission lines
- Marginal cost of generation at each bus (Lagrange multipliers)
- Shadow prices associated with binding constraints

---

## 📊 Sample Output

```txt
Circuit 3: 12.3456
Generator 1 (upper limit): 45.6789
Bus 5: 25.4321 $/MW
```

---

## 📥 Data Format

Example of expected format in `dados_sistema13B_EC4.txt`:

```txt
% Bus | Type | Pd | Qd | V | Angle | Pg | Qg
1     3      0   0   1.0  0      40  0
...
```

Make sure to follow the structure and update the values as needed for your system.

---

## 📃 License

This project is open-source and free to use for educational and research purposes.

---

## 🙋‍♂️ Author

Developed by **CayoRw**

If you find this helpful, feel free to ⭐ the repo and follow me on GitHub:  
[https://www.github.com/CayoRw](https://www.github.com/CayoRw)