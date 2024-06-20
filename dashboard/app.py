import streamlit as st
import requests
import pandas as pd
from st_aggrid import AgGrid, GridOptionsBuilder, GridUpdateMode
from streamlit_option_menu import option_menu

API_URL = "http://localhost/api/v1"

# Integration functions
def fetch_users():
    response = requests.get(API_URL + "/users")
    if response.status_code == 200:
        return response.json()  
    else:
        st.error("Failed to fetch user data")
        return []
    
def update_user_role(user_id, new_role):
    response = requests.put(API_URL + "/users/" + user_id, 
        json={"id": user_id, "role": new_role})
    return response.status_code == 200

def fetch_orders():
    response = requests.get(API_URL + "/orders")
    if response.status_code == 200:
        return response.json()  
    else:
        st.error("Failed to fetch order data")
        return []

def create_dataframe(data):
    normalized_data = []
    for entry in data:
        #medicines = "; ".join([f"{med['name']} (Batch: {med['batch']}, Stripe: {med['stripe']})" for med in entry['medicine']])
        medicine = entry['medicine']
        user = entry['user']
        normalized_data.append({
            'ID': entry['id'],
            'Created At': entry['created_at'],
            'Medicine Name': medicine['name'],
            'Batch': medicine['batch'],
            'Stripe': medicine['stripe'],
            'Quantity': entry['quantity'],
            'Priority': entry['priority'],
            'Status': entry['status'],
            'Observation': entry['observation'],
            'User Name': user['name'],
            'User Email': user['email']
        })
    df = pd.DataFrame(normalized_data)
    df['Created At'] = pd.to_datetime(df['Created At'])
    return df

# Pages
def order_management_page():
    st.title("Orders Management")
    
    data = fetch_orders()
    if data:
        df = create_dataframe(data)
        
        st.sidebar.title("Filters")
        start_date = st.sidebar.date_input("Start Date", value=pd.to_datetime(df['Created At']).min().date())
        end_date = st.sidebar.date_input("End Date", value=pd.to_datetime(df['Created At']).max().date())
        
        filtered_df = df[(df['Created At'].dt.date >= start_date) & 
                         (df['Created At'].dt.date <= end_date)]
        
        gb = GridOptionsBuilder.from_dataframe(filtered_df)
        gb.configure_pagination(paginationAutoPageSize=True)
        gb.configure_side_bar()
        grid_options = gb.build()
        
        st.write("### Registred Orders")
        AgGrid(
            filtered_df, 
            gridOptions=grid_options,
            update_mode=GridUpdateMode.SELECTION_CHANGED,
            height=500,
            width='100%'
        )
    else:
        st.warning("No data available")


def user_management_page():
    st.title("User Management")
    users = fetch_users()
    if users:
        user_df = pd.DataFrame(users)
        
        gb = GridOptionsBuilder.from_dataframe(user_df)
        gb.configure_selection('single', use_checkbox=True)
        grid_options = gb.build()
        
        st.write("### Users")
        grid_response = AgGrid(
            user_df, 
            gridOptions=grid_options,
            update_mode=GridUpdateMode.SELECTION_CHANGED,
            height=300,
            width='100%'
        )
        
        selected_rows = grid_response.get('selected_rows')
        
        if selected_rows is not None and not selected_rows.empty: 
            selected_user = selected_rows.iloc[0]
            st.write("### Edit Role")
            with st.form(key='edit_role_form'):
                st.write(f"ID: {selected_user['id']}")
                st.write(f"Name: {selected_user['name']}")
                st.write(f"Email: {selected_user['email']}")
                
                new_role = st.selectbox("Select the new role:", ["admin", "user", "collector", "manager"], index=["admin", "user", "collector", "manager"].index(selected_user["role"]))
                
                submit_button = st.form_submit_button(label='Update Role')
                
                if submit_button:
                    if update_user_role(selected_user['id'], new_role):
                        st.success("Role updated successfully!")
                        st.experimental_rerun()
                    else:
                        st.error("Something went wrong while updating the role. Please try again.")
        else:
            st.info("Select a user to edit the role.")

with st.sidebar:
    selected_page = option_menu(
        "Menu",
        ["User Management", "Orders"],
        icons=["people", "gear"],
        menu_icon="menu-app",
        default_index=0,
    )

if selected_page == "User Management":
    user_management_page()
elif selected_page == "Orders":
    order_management_page()