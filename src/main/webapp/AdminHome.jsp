<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page session="true" %>
<%
    String url = "jdbc:mysql://localhost:3306/sadaband_bank";
    String username = "root";
    String password = "shrutik@17";
    Connection con = null;
    PreparedStatement pstmt = null, transStmt = null, deleteStmt = null, updateStmt = null;
    ResultSet rs = null, transRs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, username, password);

        // Handle AJAX request for update
        String AccountNo = request.getParameter("editAccountNo");
        String newName = request.getParameter("editName");
        String newPhone = request.getParameter("editPhone");
        String newCity = request.getParameter("editCity");

        if (AccountNo != null && newName != null && newPhone != null && newCity != null) {
            try {
                String updateQuery = "UPDATE userinfo SET Firstname = ?, phone = ?, City = ? WHERE AccountNo = ?";
                updateStmt = con.prepareStatement(updateQuery);
                String[] nameParts = newName.split(" ");
                updateStmt.setString(1, nameParts[0]); // First name only
                updateStmt.setString(2, newPhone);
                updateStmt.setString(3, newCity);
                updateStmt.setInt(4, Integer.parseInt(AccountNo));
                int rowsUpdated = updateStmt.executeUpdate();
                if (rowsUpdated > 0) {
                    out.print("success");
                } else {
                    out.print("error");
                }
                updateStmt.close();
                con.close();
                return; // Stop further HTML rendering
            } catch (Exception ex) {
                out.print("error: " + ex.getMessage());
                return;
            }
        }

        // Fetch all users
        String userQuery = "SELECT * FROM userinfo";
        pstmt = con.prepareStatement(userQuery);
        rs = pstmt.executeQuery();
%>
<%
    String deleteAccountNo = request.getParameter("deleteAccountNo");

    if (deleteAccountNo != null) {
        try {
            String deleteQuery = "DELETE FROM userinfo WHERE AccountNo = ?";
            deleteStmt = con.prepareStatement(deleteQuery);
            deleteStmt.setInt(1, Integer.parseInt(deleteAccountNo));
            int rowsDeleted = deleteStmt.executeUpdate();
            if (rowsDeleted > 0) {
                out.print("success");
            } else {
                out.print("error");
            }
            deleteStmt.close();
            con.close();
            return;
        } catch (Exception ex) {
            out.print("error: " + ex.getMessage());
            return;
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel</title>
    <style>
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid black; padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
        .delete-btn { background-color: red; color: white; border: none; padding: 5px 10px; cursor: pointer; }
        .save-btn { background-color: green; color: white; border: none; padding: 5px 10px; cursor: pointer; }
        .edit-input { width: 100px; }
    </style>
    <script>
        function deleteUser(AccountNo) {
            if (!confirm("Are you sure you want to delete this user?")) return;

            var xhr = new XMLHttpRequest();
            xhr.open("POST", "AdminHome.jsp", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        if (xhr.responseText.trim() === "success") {
                            alert("User deleted successfully.");
                            document.getElementById("row-" + AccountNo).remove(); // Remove row from table
                        } else {
                            alert("Failed to delete user: " + xhr.responseText);
                        }
                    } else {
                        alert("Error: " + xhr.status);
                    }
                }
            };

            xhr.send("deleteAccountNo=" + AccountNo);
        }

        function editUser(AccountNo) {
            document.getElementById("name-" + AccountNo).contentEditable = "true";
            document.getElementById("phone-" + AccountNo).contentEditable = "true";
            document.getElementById("city-" + AccountNo).contentEditable = "true";

            document.getElementById("save-" + AccountNo).style.display = "inline";
        }

        function saveUser(AccountNo) {
            var newName = document.getElementById("name-" + AccountNo).innerText.trim();
            var newPhone = document.getElementById("phone-" + AccountNo).innerText.trim();
            var newCity = document.getElementById("city-" + AccountNo).innerText.trim();

            var xhr = new XMLHttpRequest();
            xhr.open("POST", "AdminHome.jsp", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        if (xhr.responseText.trim() === "success") {
                            alert("User updated successfully.");
                            document.getElementById("name-" + AccountNo).contentEditable = "false";
                            document.getElementById("phone-" + AccountNo).contentEditable = "false";
                            document.getElementById("city-" + AccountNo).contentEditable = "false";
                            document.getElementById("save-" + AccountNo).style.display = "none";
                        } else {
                            alert("Failed to update user: " + xhr.responseText);
                        }
                    } else {
                        alert("Error: " + xhr.status);
                    }
                }
            };

            xhr.send("editAccountNo=" + AccountNo + "&editName=" + newName + "&editPhone=" + newPhone + "&editCity=" + newCity);
        }
    </script>
</head>
<body>
    <h2>Admin Dashboard</h2>

    <h3>User Accounts</h3>
    <table>
        <tr>
            <th>Account No</th> <th>Name</th> <th>Phone</th> <th>City</th> <th>Actions</th>
        </tr>
        <% while (rs.next()) { %>
        <tr id="row-<%= rs.getInt("AccountNo") %>">
            <td><%= rs.getInt("AccountNo") %></td>
            <td id="name-<%= rs.getInt("AccountNo") %>"><%= rs.getString("Firstname") + " " + rs.getString("Lastname") %></td>
            <td id="phone-<%= rs.getInt("AccountNo") %>"><%= rs.getString("phone") %></td>
            <td id="city-<%= rs.getInt("AccountNo") %>"><%= rs.getString("City") %></td>
            <td>
                <button onclick="editUser(<%= rs.getInt("AccountNo") %>)">Edit</button>
                <button class="save-btn" id="save-<%= rs.getInt("AccountNo") %>" style="display:none;" onclick="saveUser(<%= rs.getInt("AccountNo") %>)">Save</button>
                <button class="delete-btn" onclick="deleteUser(<%= rs.getInt("AccountNo") %>)">Delete</button>
            </td>
        </tr>
        <% } %>
    </table>

    <h3>Transactions</h3>
    <table>
        <tr>
            <th>Transaction ID</th> <th>User ID</th> <th>Amount</th> <th>Type</th> <th>Date</th>
        </tr>
        <%
            String transactionQuery = "SELECT * FROM transactions";
            transStmt = con.prepareStatement(transactionQuery);
            transRs = transStmt.executeQuery();
            while (transRs.next()) {
        %>
        <tr>
            <td><%= transRs.getInt("id") %></td>
            <td><%= transRs.getInt("user_id") %></td>
            <td><%= transRs.getBigDecimal("amount") %></td>
            <td><%= transRs.getString("type") %></td>
            <td><%= transRs.getTimestamp("date") %></td>
        </tr>
        <% } %>
    </table>
</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (con != null) con.close();
    }
%>
