class User {
  String? authToken;
  String? name;
  String? email;
  String? phone;
  String? avatarUrl;
  String? employeeId;
  Role? role;

  User({this.authToken, this.name, this.email, this.phone, this.role, this.employeeId});

  User.fromJson(Map<String, dynamic> json) {
    authToken = json['authToken'];
    name = json['name'];
    email = json['email'];
    avatarUrl = json['profileAvatarSrc'];
    employeeId = json['employeeId'];
    phone = json['phone'];
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authToken'] = authToken;
    data['name'] = name;
    data['employeeId'] = employeeId;
    data['profileAvatarSrc'] = avatarUrl;
    data['email'] = email;
    data['phone'] = phone;
    if (role != null) {
      data['role'] = role!.toJson();
    }
    return data;
  }
}

class Role {
  String? sId;
  String? name;
  String? description;
  bool? salesDashboard;
  bool? operationsDashboard;
  bool? financeDashboard;
  bool? leadsTable;
  bool? importLeads;
  bool? exportLeads;
  bool? createLead;
  bool? assignLeads;
  bool? checkAvailability;
  bool? leadSummary;
  bool? jobsTable;
  bool? importJobs;
  bool? exportJobs;
  bool? assignJob;
  bool? createJob;
  bool? jobSummary;
  bool? basicCalendar;
  bool? resourceCalendar;
  bool? employeeTable;
  bool? createEmployee;
  bool? truckTable;
  bool? addTruck;
  bool? subcontractorTable;
  bool? createSubcontractor;
  bool? payrollTable;
  bool? viewEmails;
  bool? sendEmails;
  bool? sourceTable;
  bool? addSource;
  bool? exportSource;
  bool? generalSetting;
  bool? rolesandPermisions;
  bool? pricingSetting;
  bool? inventorySetting;
  bool? emailTemplates;
  bool? documentTemplate;
  bool? integrationSetting;
  bool? status;
  String? createdAt;

  Role(
      {this.sId,
        this.name,
        this.description,
        this.salesDashboard,
        this.operationsDashboard,
        this.financeDashboard,
        this.leadsTable,
        this.importLeads,
        this.exportLeads,
        this.createLead,
        this.assignLeads,
        this.checkAvailability,
        this.leadSummary,
        this.jobsTable,
        this.importJobs,
        this.exportJobs,
        this.assignJob,
        this.createJob,
        this.jobSummary,
        this.basicCalendar,
        this.resourceCalendar,
        this.employeeTable,
        this.createEmployee,
        this.truckTable,
        this.addTruck,
        this.subcontractorTable,
        this.createSubcontractor,
        this.payrollTable,
        this.viewEmails,
        this.sendEmails,
        this.sourceTable,
        this.addSource,
        this.exportSource,
        this.generalSetting,
        this.rolesandPermisions,
        this.pricingSetting,
        this.inventorySetting,
        this.emailTemplates,
        this.documentTemplate,
        this.integrationSetting,
        this.status,
        this.createdAt,});

  Role.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    salesDashboard = json['SalesDashboard'];
    operationsDashboard = json['OperationsDashboard'];
    financeDashboard = json['FinanceDashboard'];
    leadsTable = json['LeadsTable'];
    importLeads = json['ImportLeads'];
    exportLeads = json['ExportLeads'];
    createLead = json['CreateLead'];
    assignLeads = json['AssignLeads'];
    checkAvailability = json['CheckAvailability'];
    leadSummary = json['LeadSummary'];
    jobsTable = json['JobsTable'];
    importJobs = json['ImportJobs'];
    exportJobs = json['ExportJobs'];
    assignJob = json['AssignJob'];
    createJob = json['CreateJob'];
    jobSummary = json['JobSummary'];
    basicCalendar = json['BasicCalendar'];
    resourceCalendar = json['ResourceCalendar'];
    employeeTable = json['EmployeeTable'];
    createEmployee = json['CreateEmployee'];
    truckTable = json['TruckTable'];
    addTruck = json['AddTruck'];
    subcontractorTable = json['SubcontractorTable'];
    createSubcontractor = json['CreateSubcontractor'];
    payrollTable = json['PayrollTable'];
    viewEmails = json['ViewEmails'];
    sendEmails = json['SendEmails'];
    sourceTable = json['SourceTable'];
    addSource = json['AddSource'];
    exportSource = json['ExportSource'];
    generalSetting = json['GeneralSetting'];
    rolesandPermisions = json['RolesandPermisions'];
    pricingSetting = json['PricingSetting'];
    inventorySetting = json['InventorySetting'];
    emailTemplates = json['EmailTemplates'];
    documentTemplate = json['DocumentTemplate'];
    integrationSetting = json['IntegrationSetting'];
    status = json['status'];
    createdAt = json['CreatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['SalesDashboard'] = salesDashboard;
    data['OperationsDashboard'] = operationsDashboard;
    data['FinanceDashboard'] = financeDashboard;
    data['LeadsTable'] = leadsTable;
    data['ImportLeads'] = importLeads;
    data['ExportLeads'] = exportLeads;
    data['CreateLead'] = createLead;
    data['AssignLeads'] = assignLeads;
    data['CheckAvailability'] = checkAvailability;
    data['LeadSummary'] = leadSummary;
    data['JobsTable'] = jobsTable;
    data['ImportJobs'] = importJobs;
    data['ExportJobs'] = exportJobs;
    data['AssignJob'] = assignJob;
    data['CreateJob'] = createJob;
    data['JobSummary'] = jobSummary;
    data['BasicCalendar'] = basicCalendar;
    data['ResourceCalendar'] = resourceCalendar;
    data['EmployeeTable'] = employeeTable;
    data['CreateEmployee'] = createEmployee;
    data['TruckTable'] = truckTable;
    data['AddTruck'] = addTruck;
    data['SubcontractorTable'] = subcontractorTable;
    data['CreateSubcontractor'] = createSubcontractor;
    data['PayrollTable'] = payrollTable;
    data['ViewEmails'] = viewEmails;
    data['SendEmails'] = sendEmails;
    data['SourceTable'] = sourceTable;
    data['AddSource'] = addSource;
    data['ExportSource'] = exportSource;
    data['GeneralSetting'] = generalSetting;
    data['RolesandPermisions'] = rolesandPermisions;
    data['PricingSetting'] = pricingSetting;
    data['InventorySetting'] = inventorySetting;
    data['EmailTemplates'] = emailTemplates;
    data['DocumentTemplate'] = documentTemplate;
    data['IntegrationSetting'] = integrationSetting;
    data['status'] = status;
    data['CreatedAt'] = createdAt;
    return data;
  }
}
