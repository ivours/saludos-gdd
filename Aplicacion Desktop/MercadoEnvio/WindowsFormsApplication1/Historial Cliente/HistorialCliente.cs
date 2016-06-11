using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication1.Historial_Cliente
{
    public partial class HistorialCliente : Form
    {
        String username;

        public HistorialCliente(String username)
        {
            InitializeComponent();
            this.username = username;
            this.inicializarCampos();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void inicializarCampos()
        {
            this.inicializarResumenDeEstrellasDadas();
        }

        private void inicializarResumenDeEstrellasDadas()
        {
            textBox1.Text = this.cuantasEstrellasPara(1).ToString();
            textBox2.Text = this.cuantasEstrellasPara(2).ToString();
            textBox7.Text = this.cuantasEstrellasPara(3).ToString();
            textBox8.Text = this.cuantasEstrellasPara(4).ToString();
            textBox9.Text = this.cuantasEstrellasPara(5).ToString();
        }

        private void inicializarCantidadCalificacionesPendientes()
        {
            textBox3.Text = this.cantidadCalificacionesPendientes().ToString();
        }

        private void inicializarCantidadComprasRealizadas()
        {
            textBox6.Text = this.cantidadComprasRealizadas().ToString();
        }

        private void inicializarSubastasGanadas()
        {
            textBox10.Text = this.cantidadSubastasGanadas().ToString();
        }

        private void inicializarTotalOperaciones()
        {
            textBox11.Text = (this.cantidadComprasRealizadas() + this.cantidadSubastasGanadas()).ToString();
        }

        private int cuantasEstrellasPara(int estrellas)
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT GD1C2016.SALUDOS.cuantasEstrellasPara(@usuario, @estrellas)";
            consulta.Parameters.Add(new SqlParameter("@usuario", this.username));
            consulta.Parameters.Add(new SqlParameter("@estrellas", estrellas));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();
            reader.Read();

            return (int)reader.GetValue(0);
        }

        private int cantidadCalificacionesPendientes()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT GD1C2016.SALUDOS.cantidadCalificacionesPendientes(@usuario)";
            consulta.Parameters.Add(new SqlParameter("@usuario", this.username));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();
            reader.Read();

            return (int)reader.GetValue(0);
        }

        private int cantidadComprasRealizadas()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT GD1C2016.SALUDOS.cantidadComprasRealizadas(@usuario)";
            consulta.Parameters.Add(new SqlParameter("@usuario", this.username));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();
            reader.Read();

            return (int)reader.GetValue(0);
        }

        private int cantidadSubastasGanadas()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT GD1C2016.SALUDOS.cantidadSubastasGanadas(@usuario)";
            consulta.Parameters.Add(new SqlParameter("@usuario", this.username));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();
            reader.Read();

            return (int)reader.GetValue(0);
        }
    }
}