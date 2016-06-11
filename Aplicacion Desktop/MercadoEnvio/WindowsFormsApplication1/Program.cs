using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Windows.Forms;
using System.Configuration;
using WindowsFormsApplication1.Dominio;

namespace WindowsFormsApplication1
{
    static class Program
    {
        /// <summary>
        /// Punto de entrada principal para la aplicación.
        /// </summary>
        /// 

        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Fecha.asignarFecha();
            Application.Run(new Login.Login());

            return;
        }

        public static SqlConnection conexionDB()
        {
            string configuracion = ConfigurationManager.AppSettings["configuracionSQL"].ToString();
            SqlConnection conexion = new SqlConnection(configuracion);
            conexion.Open();
            SqlCommand comm = new SqlCommand("SET ARITHABORT ON", conexion);
            comm.ExecuteNonQuery();
            return conexion;
        }

    }
}
