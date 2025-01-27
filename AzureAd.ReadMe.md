# Adding Azure Active Directory (Azure AD) as an Identity Provider to Keycloak

This guide explains how to configure Azure Active Directory (Azure AD) as an identity provider for Keycloak. This enables users from Azure AD to log in to applications integrated with Keycloak.

---

## **Prerequisites**
- Access to the Azure AD portal.
- Administrator rights in Keycloak.
- A registered application in Azure AD (to obtain credentials like Client ID and Secret).

---

## **Step 1: Register the Application in Azure AD**

### **1.1 Go to Azure Portal**
1. Log in to the [Azure Portal](https://portal.azure.com).

### **1.2 Register an Application**
1. Navigate to **Azure Active Directory > App Registrations > New Registration**.
2. Provide a name for your application (e.g., `KeycloakIntegration`).
3. Choose **Accounts in this organizational directory only** (or another option based on your use case).
4. Set the **Redirect URI** as:
   ```
   https://<your-keycloak-host>/realms/<your-realm>/broker/azure/callback
   ```
   Replace `<your-keycloak-host>` with your Keycloak server's URL and `<your-realm>` with the target realm.

### **1.3 Note Down the Application ID**
1. After registering, note the **Application (client) ID** and **Directory (tenant) ID** from the app's **Overview** page.

### **1.4 Generate a Client Secret**
1. Go to **Certificates & Secrets > New Client Secret**.
2. Add a description and set an expiration period.
3. Copy the secret value (you won't be able to view it again).

### **1.5 Configure API Permissions**
1. Go to **API Permissions > Add a permission > Microsoft Graph**.
2. Choose **Delegated Permissions** and select the following:
   - `openid`
   - `email`
   - `profile`

---

## **Step 2: Configure Azure AD in Keycloak**

### **2.1 Log in to the Keycloak Admin Console**
1. Navigate to your Keycloak instance.
2. Log in as an administrator.

### **2.2 Add Azure AD as an Identity Provider**
1. Go to **Realm Settings > Identity Providers**.
2. Click **Add Provider** and select **OpenID Connect v1.0**.

### **2.3 Configure Azure AD Provider Settings**
1. Fill in the fields as follows:
   - **Alias**: `azure` (or any identifier for Azure AD).
   - **Display Name**: `Azure AD` (or another name for the login button).
   - **Authorization URL**:  
     ```
     https://login.microsoftonline.com/<tenant-id>/oauth2/v2.0/authorize
     ```
     Replace `<tenant-id>` with your Azure AD Tenant ID.
   - **Token URL**:  
     ```
     https://login.microsoftonline.com/<tenant-id>/oauth2/v2.0/token
     ```
     Replace `<tenant-id>` with your Azure AD Tenant ID.
   - **Logout URL**:  
     ```
     https://login.microsoftonline.com/<tenant-id>/oauth2/v2.0/logout
     ```
   - **Client ID**: Your Azure AD Application (client) ID.
   - **Client Secret**: The secret generated in Azure AD.

2. Add the following scopes in the **Default Scopes** field:
   ```
   openid email profile
   ```
3. Click **Save**.

---

## **Step 3: Test the Integration**

### **3.1 Enable Azure AD Login for the Realm**
1. Navigate to your realm's login page.
2. Ensure the Azure AD login button is visible.

### **3.2 Try Logging In**
1. Click the **Azure AD** button.
2. Log in using your Azure AD credentials.
3. If successful, you will be redirected to Keycloak.

---

## **Step 4: Optional Configuration**

### **4.1 Map Azure AD Attributes to Keycloak**
1. Go to **Identity Providers** > **Mappers** for Azure AD.
2. Add mappers to link Azure AD user attributes (e.g., `email`, `name`, `roles`) to Keycloak user attributes.

### **4.2 Debugging Errors**
1. If something doesn't work, enable debug logs in Keycloak.
2. Check Keycloak logs for detailed error messages.

---

This completes the setup of Azure AD as an identity provider in Keycloak. If you encounter any issues or need further clarification, feel free to reach out!

