Here’s a **README file** to set up a **Keycloak OpenID Connect provider** by adding another Keycloak instance as an identity provider:

---

# **Adding Keycloak OpenID Connect Provider**

This guide explains how to add a Keycloak instance as an **OpenID Connect (OIDC)** identity provider to another Keycloak instance. This allows users from the secondary Keycloak (child) to authenticate through the primary Keycloak (master).

---

## **Prerequisites**
- Two Keycloak instances (master and child).
- Administrator access to both Keycloak instances.
- The realm name, client ID, and client secret (if required) of the child Keycloak.
- Network connectivity between the two Keycloak instances.

---

## **Step 1: Configure the Child Keycloak Instance**

### **1.1 Obtain the OIDC Configuration Endpoint**
1. Log in to the child Keycloak admin console.
2. Navigate to **Realm Settings > Endpoints**.
3. Copy the OpenID Connect discovery URL for the child realm:
   ```
   https://<child-keycloak-host>/realms/<child-realm>/.well-known/openid-configuration
   ```
   Replace `<child-keycloak-host>` with the child Keycloak URL and `<child-realm>` with the realm name.

---

## **Step 2: Configure the Master Keycloak Instance**

### **2.1 Log in to the Master Keycloak Admin Console**
1. Access the master Keycloak admin console.
2. Log in as an administrator.

### **2.2 Add the Child Keycloak as an Identity Provider**
1. Go to **Realm Settings > Identity Providers** in the master Keycloak.
2. Click **Add Provider** and select **OpenID Connect v1.0**.

### **2.3 Configure the Identity Provider Settings**
1. Fill in the fields as follows:
   - **Alias**: A unique identifier for the child Keycloak (e.g., `child-keycloak`).
   - **Display Name**: The name that will appear on the login button (e.g., `Child Keycloak`).
   - **Authorization URL**:
     ```
     https://<child-keycloak-host>/realms/<child-realm>/protocol/openid-connect/auth
     ```
   - **Token URL**:
     ```
     https://<child-keycloak-host>/realms/<child-realm>/protocol/openid-connect/token
     ```
   - **Logout URL**:
     ```
     https://<child-keycloak-host>/realms/<child-realm>/protocol/openid-connect/logout
     ```
   - **Issuer**:
     ```
     https://<child-keycloak-host>/realms/<child-realm>
     ```
   - **Client ID**: Enter a valid client ID from the child Keycloak realm (e.g., `account` or a custom client ID).
   - **Client Secret**: Enter the client secret if required (can be generated in the child Keycloak under **Clients > Credentials**).

2. Add the following scopes to the **Default Scopes** field:
   ```
   openid email profile
   ```

3. Click **Save**.

---

## **Step 3: Test the Integration**

### **3.1 Enable Login from the Child Keycloak**
1. Navigate to the login page of the master Keycloak realm.
2. You should see a login button labeled with the display name you configured (e.g., `Child Keycloak`).

### **3.2 Test User Login**
1. Click the **Child Keycloak** login button.
2. You will be redirected to the child Keycloak login page.
3. Log in using valid credentials from the child Keycloak realm.
4. If successful, you will be redirected back to the master Keycloak and logged in.

---

## **Step 4: Optional Configuration**

### **4.1 Map User Attributes**
1. In the master Keycloak admin console, go to **Identity Providers > Mappers** for the child Keycloak.
2. Add mappers to map attributes (e.g., `email`, `name`, `roles`) from the child Keycloak to the master Keycloak.

### **4.2 Set Up Debugging**
1. Enable debug logs in both Keycloak instances if authentication fails.
2. Verify that both Keycloak instances are using compatible OIDC configurations.

---

## **Troubleshooting**
- **Error: Invalid client credentials:** Ensure that the client ID and secret are correct in both instances.
- **Login button not visible:** Check that the identity provider is enabled in the master Keycloak.
- **Redirect issues:** Verify that the correct redirect URI is configured in the child Keycloak client.

---

This setup creates a seamless integration between two Keycloak instances using OpenID Connect, enabling federated authentication. If you encounter any issues or need additional help, feel free to ask!