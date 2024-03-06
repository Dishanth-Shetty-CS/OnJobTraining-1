public class EmpClass {
	String emp_name, company_name;
	float emp_salary;
	int emp_id;
	long mobile_num;	
	
	public void showEmpDetails() {
		System.out.println("Employee name: " + emp_name);
		System.out.println("Employee Id: " + emp_id);
		System.out.println("Employee salary: " + emp_salary);
		System.out.println("Mobile number: " + mobile_num);
		System.out.println("Company name: " + company_name);
	}
	
	public void updateSalary(float emp_salary) {
		this.emp_salary = emp_salary;
	}
	
	public void updatePhone(long mobile_num) {
		this.mobile_num = mobile_num;
	}
	
	public void showCompanyName() {
		System.out.println("Company name: " + company_name);
	}
	
	public static void main(String[] args) {
		EmpClass empObj = new EmpClass();
		empObj.emp_name = "Rohan";
		empObj.company_name = "Google";
		empObj.emp_salary = 45000;
		empObj.emp_id = 123;
		empObj.mobile_num = 8965222541L;
		
		empObj.showEmpDetails();
		System.out.println("\n");
		empObj.showCompanyName();
		System.out.println("\n");
		empObj.updateSalary(55000);		
		empObj.updatePhone(9874458962L);
		empObj.showEmpDetails();
	}
}