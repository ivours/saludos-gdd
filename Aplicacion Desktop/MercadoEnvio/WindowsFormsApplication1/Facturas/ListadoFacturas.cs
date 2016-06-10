using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using WindowsFormsApplication1.Dominio;

namespace WindowsFormsApplication1.Facturas
{
    public partial class ListadoFacturas : Form
    {
        String username;
        int paginaActual;
        int ultimaPagina;

        public ListadoFacturas(String username)
        {
            InitializeComponent();
            ConfiguradorDataGrid.configurar(dataGridView1);
            dataGridView1.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            this.username = username;
            this.inicializarCampos();
        }

        private void inicializarCampos()
        {
            if (!Dominio.Usuario.getTipoUsuario(username).Equals("Administrador"))
            {
                textBox3.Text = username;
                textBox3.ReadOnly = true;
            }

            this.paginaActual = 0;
            this.ultimaPagina = 0;

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        //TODO: Ver si hace falta validar los otros campos
        private void validarCampos()
        {
            this.validarIntervaloFechas();
            this.validarIntervaloImportes();
        }
        
        private void validarIntervaloFechas()
        {
            DateTime extremoInferiorIntervaloFecha = Convert.ToDateTime(textBox6.Text);
            DateTime extremoSuperiorIntervaloFecha = Convert.ToDateTime(textBox7.Text);

            if (extremoInferiorIntervaloFecha.CompareTo(extremoSuperiorIntervaloFecha) > 0)
                throw new Exception("El extremo inferior del intervalo de fechas no puede ser mayor al extremo superior");

            if (extremoInferiorIntervaloFecha.CompareTo(Dominio.Fecha.getFechaActual()) > 0)
                throw new Exception("La fecha del extremo inferior del intervalo de fechas no puede ser mayor a la fecha actual");

            if (extremoSuperiorIntervaloFecha.CompareTo(Dominio.Fecha.getFechaActual()) > 0)
                throw new Exception("La fecha del extremo superior del intervalo de fechas no puede ser mayor a la fecha actual");
        }

        private void validarIntervaloImportes()
        {
            if (numericUpDown1.Value > numericUpDown2.Value)
                throw new Exception("El extremo inferior del intervalo de importes no puede ser mayor al extremo superior");
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.limpiarCampos();
        }

        private void limpiarCampos()
        {
            textBox1.Clear();
            textBox2.Clear();
            textBox3.Clear();
            textBox4.Clear();
            textBox5.Clear();
            textBox6.Clear();
            textBox7.Clear();
            numericUpDown1.Value = 0;
            numericUpDown2.Value = 0;
            dataGridView1.DataSource = null;
            dataGridView1.Refresh();
            this.inicializarCampos();
        }

        private void button9_Click(object sender, EventArgs e)
        {
            SeleccionarFecha seleccionarFecha = new SeleccionarFecha(textBox6);
            seleccionarFecha.Show();

        }

        private void button10_Click(object sender, EventArgs e)
        {
            SeleccionarFecha seleccionarFecha = new SeleccionarFecha(textBox7);
            seleccionarFecha.Show();
        }

        private void button7_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private SqlDataReader facturasRealizadasAlVendedor()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.facturasRealizadasAlVendedor(@fechaInicio, @fechaFinalizacion, @codigoPublicacion, @codigoFactura, @importeMinimo, @importeMaximo, @destinatario)";
            consulta.Parameters.Add(new SqlParameter("@fechaInicio", this.filtrarFechaInicio()));
            consulta.Parameters.Add(new SqlParameter("@fechaFinalizacion", this.filtrarFechaFinalizacion()));
            consulta.Parameters.Add(new SqlParameter("@codigoPublicacion", this.filtrarCodigoPublicacion()));
            consulta.Parameters.Add(new SqlParameter("@codigoFactura", this.filtrarCodigoFactura()));
            consulta.Parameters.Add(new SqlParameter("@importeMinimo", this.filtrarImporteMinimo()));
            consulta.Parameters.Add(new SqlParameter("@importeMaximo", this.filtrarImporteMaximo()));
            consulta.Parameters.Add(new SqlParameter("@destinatario", this.filtrarDestinatario()));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return reader;
        }

        private Object filtrarDestinatario()
        {
            if (!textBox3.Text.Equals(""))
                return textBox3.Text;
            else
                return DBNull.Value;
        }

        private Object filtrarImporteMaximo()
        {
            if (!numericUpDown2.Value.Equals(0))
                return Convert.ToInt32(numericUpDown2.Value);
            else
                return DBNull.Value;
        }

        private Object filtrarImporteMinimo()
        {
            if (!numericUpDown1.Value.Equals(0))
                return Convert.ToInt32(numericUpDown1.Value);
            else
                return DBNull.Value;
        }

        private Object filtrarCodigoFactura()
        {
            if (!textBox2.Text.Equals(""))
                return Convert.ToInt32(textBox2.Text);
            else
                return DBNull.Value;
        }

        private Object filtrarCodigoPublicacion()
        {
            if(!textBox1.Text.Equals(""))
                return Convert.ToInt32(textBox1.Text);
            else 
                return DBNull.Value;
        }

        private Object filtrarFechaInicio()
        {
            if (!textBox6.Text.Equals(""))
                return Convert.ToDateTime(textBox6.Text);
            else
                return DBNull.Value;
        }

        private Object filtrarFechaFinalizacion()
        {
            if (!textBox7.Text.Equals(""))
                return Convert.ToDateTime(textBox7.Text);
            else
                return DBNull.Value;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            ConfiguradorDataGrid.llenarDataGridConConsulta(this.facturasRealizadasAlVendedor(),dataGridView1);
            this.paginaActual = 0;
            dataGridView1.FirstDisplayedScrollingRowIndex = 0;
            textBox4.Text = "0";
            int cantidadDeFacturas = dataGridView1.RowCount;
            int cantidadDePaginas = Convert.ToInt32(Convert.ToDouble(cantidadDeFacturas / 10));
            this.ultimaPagina = cantidadDePaginas - 1;
            textBox5.Text = this.ultimaPagina.ToString();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            this.avanzarPagina();
        }

        private void avanzarPagina()
        {
            if (paginaActual < ultimaPagina)
            {
                paginaActual = paginaActual + 1;
                textBox4.Text = paginaActual.ToString();
                dataGridView1.FirstDisplayedScrollingRowIndex = paginaActual * 10;
                dataGridView1.Refresh();
            }
        }

        private void retrocederPagina()
        {
            if (paginaActual > 0)
            {
                paginaActual = paginaActual - 1;
                textBox4.Text = paginaActual.ToString();
                dataGridView1.FirstDisplayedScrollingRowIndex = paginaActual * 10;
                dataGridView1.Refresh();
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.retrocederPagina();
        }

        private void irAPrimeraPagina()
        {
            dataGridView1.FirstDisplayedScrollingRowIndex = 0;
            paginaActual = 0;
            textBox4.Text = paginaActual.ToString();
            dataGridView1.Refresh();
        }

        private void irAUltimaPagina()
        {
            dataGridView1.FirstDisplayedScrollingRowIndex = ultimaPagina * 10;
            paginaActual = ultimaPagina;
            textBox4.Text = paginaActual.ToString();
            dataGridView1.Refresh();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            this.irAPrimeraPagina();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            this.irAUltimaPagina();
        }

        private void verDetalleFactura()
        {
            int codigoFactura = Convert.ToInt32(dataGridView1.SelectedRows[0].Cells[0].Value);
            int codigoPublicacion = Convert.ToInt32(dataGridView1.SelectedRows[0].Cells[1].Value);
            decimal total= Convert.ToDecimal(dataGridView1.SelectedRows[0].Cells[3].Value);
            DateTime fechaFacturacion = Convert.ToDateTime(dataGridView1.SelectedRows[0].Cells[4].Value);

            String destinatario;
            
            if (Usuario.getTipoUsuario(username).Equals("Administrador"))
                destinatario = dataGridView1.SelectedRows[0].Cells[2].Value.ToString();
            else
                destinatario = textBox3.Text;

            DetalleFactura detalleFactura = new DetalleFactura(codigoFactura, codigoPublicacion, destinatario, fechaFacturacion, total);
            detalleFactura.Show();
        }

        private void button8_Click(object sender, EventArgs e)
        {
            this.verDetalleFactura();
        }
    }
}
