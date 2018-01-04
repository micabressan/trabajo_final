Imports System.Net.Mail
Public Class Form1

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim MyMailMessage As New MailMessage()
        Try
            MyMailMessage.From = New MailAddress("")
            MyMailMessage.To.Add("")
            MyMailMessage.Subject = TextBox1.Text
            MyMailMessage.Body = TextBox2.Text
            Dim SMTP As New SmtpClient("smtp.gmail.com")
            SMTP.Port = 587
            SMTP.EnableSsl = True
            SMTP.Credentials = New System.Net.NetworkCredential("", "")
            SMTP.Send(MyMailMessage)
            TextBox2.Text = ""
        Catch ex As Exception

        End Try

    End Sub
End Class