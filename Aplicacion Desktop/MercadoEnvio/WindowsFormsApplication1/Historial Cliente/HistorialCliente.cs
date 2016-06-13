using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using WindowsFormsApplication1.Extras;

namespace WindowsFormsApplication1.Historial_Cliente
{
    public partial class HistorialCliente : Form
    {
        String username;
        int paginaActual;
        int ultimaPagina;

        public HistorialCliente(String username)
        {
            InitializeComponent();
            ConfiguradorVentana.configurarVentana(this);
            this.username = username;
            this.inicializarCampos();
            ConfiguradorDataGrid.configurar(dataGridView1);
            ConfiguradorDataGrid.configurar(dataGridView2);
            dataGridView1.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dataGridView2.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            ConfiguradorDataGrid.llenarDataGridConConsulta(this.ultimasCincoCalificaciones(), dataGridView2);
            radioButton1.Checked = true;
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void inicializarCampos()
        {
            this.inicializarResumenDeEstrellasDadas();
            this.inicializarCantidadCalificacionesPendientes();
            this.inicializarCantidadComprasRealizadas();
            this.inicializarSubastasGanadas();
            this.inicializarTotalOperaciones();
            this.ultimaPagina = 1;
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

        private int cantidadDePaginasHistorialDe(String tipoDePublicacion)
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT GD1C2016.SALUDOS.cantidadDePaginasHistorialDe(@usuario, @tipoDePublicacion)";
            consulta.Parameters.Add(new SqlParameter("@usuario", this.username));
            consulta.Parameters.Add(new SqlParameter("@tipoDePublicacion", tipoDePublicacion));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();
            reader.Read();

            return (int)reader.GetValue(0);
        }

        private SqlDataReader historialDeCompras()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.historialDeCompras(@usuario) ORDER BY Fecha,Código_Compra OFFSET ((@NUM_PAG - 1) * 10) ROWS FETCH NEXT 10 ROWS ONLY";
            consulta.Parameters.Add(new SqlParameter("@usuario", this.username));
            consulta.Parameters.Add(new SqlParameter("@NUM_PAG", paginaActual));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return reader;
        }

        private SqlDataReader historialDeOfertas()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.historialDeOfertas(@usuario) ORDER BY Fecha,Código_Oferta OFFSET ((@NUM_PAG - 1) * 10) ROWS FETCH NEXT 10 ROWS ONLY";
            consulta.Parameters.Add(new SqlParameter("@usuario", this.username));
            consulta.Parameters.Add(new SqlParameter("@NUM_PAG", paginaActual));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return reader;
        }

        private SqlDataReader ultimasCincoCalificaciones()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.ultimasCincoCalificaciones(@usuario)";
            consulta.Parameters.Add(new SqlParameter("@usuario", this.username));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return reader;
        }

        private void avanzarPagina()
        {
            if (radioButton1.Checked.Equals(true))
            {
                if (paginaActual < ultimaPagina)
                {
                    paginaActual = paginaActual + 1;
                    textBox4.Text = paginaActual.ToString();
                    ConfiguradorDataGrid.llenarDataGridConConsulta(this.historialDeCompras(), dataGridView1);
                }
            }
            else
            {
                if (radioButton2.Checked.Equals(true))
                {
                    if (paginaActual < ultimaPagina)
                    {
                        paginaActual = paginaActual + 1;
                        textBox4.Text = paginaActual.ToString();
                        ConfiguradorDataGrid.llenarDataGridConConsulta(this.historialDeOfertas(), dataGridView1);
                    }
                }
            }
        }

        private void retrocederPagina()
        {
            if (radioButton1.Checked.Equals(true))
            {
                if (paginaActual > 1)
                {
                    paginaActual = paginaActual - 1;
                    textBox4.Text = paginaActual.ToString();
                    ConfiguradorDataGrid.llenarDataGridConConsulta(this.historialDeCompras(), dataGridView1);
                }
            }
            else
            {
                if (radioButton2.Checked.Equals(true))
                {
                    if (paginaActual > 1)
                    {
                        paginaActual = paginaActual - 1;
                        textBox4.Text = paginaActual.ToString();
                        ConfiguradorDataGrid.llenarDataGridConConsulta(this.historialDeOfertas(), dataGridView1);
                    }
                }
            }
        }

        private void irAPrimeraPagina()
        {
            paginaActual = 1;
            textBox4.Text = paginaActual.ToString();

            if(radioButton1.Checked.Equals(true))
                ConfiguradorDataGrid.llenarDataGridConConsulta(this.historialDeCompras(), dataGridView1);
            else if (radioButton2.Checked.Equals(true))
                ConfiguradorDataGrid.llenarDataGridConConsulta(this.historialDeOfertas(), dataGridView1);
        }

        private void irAUltimaPagina()
        {
            paginaActual = ultimaPagina;
            textBox4.Text = paginaActual.ToString();

            if (radioButton1.Checked.Equals(true))
                ConfiguradorDataGrid.llenarDataGridConConsulta(this.historialDeCompras(), dataGridView1);
            else if (radioButton2.Checked.Equals(true))
                ConfiguradorDataGrid.llenarDataGridConConsulta(this.historialDeOfertas(), dataGridView1);
        }

        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {
            this.paginaActual = 1;
            this.ultimaPagina = this.cantidadDePaginasHistorialDe("Compras");
            textBox4.Text = this.paginaActual.ToString();
            textBox5.Text = this.ultimaPagina.ToString();
            ConfiguradorDataGrid.llenarDataGridConConsulta(this.historialDeCompras(), dataGridView1);
        }

        private void radioButton2_CheckedChanged(object sender, EventArgs e)
        {
            this.paginaActual = 1;
            this.ultimaPagina = this.cantidadDePaginasHistorialDe("Ofertas");
            textBox4.Text = this.paginaActual.ToString();
            textBox5.Text = this.ultimaPagina.ToString();
            ConfiguradorDataGrid.llenarDataGridConConsulta(this.historialDeOfertas(), dataGridView1);
        }

        private void button5_Click(object sender, EventArgs e)
        {
            this.irAPrimeraPagina();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.retrocederPagina();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            this.avanzarPagina();
        }

        private void button6_Click_1(object sender, EventArgs e)
        {
            this.irAUltimaPagina();
        }
    }
}