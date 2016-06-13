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
using WindowsFormsApplication1.Extras;

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
            ConfiguradorVentana.configurarVentana(this);
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

            this.paginaActual = 1;
            this.ultimaPagina = 1;

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
            if (!textBox6.Text.Length.Equals(0))
            {
                DateTime extremoInferiorIntervaloFecha = Convert.ToDateTime(textBox6.Text);
                if (extremoInferiorIntervaloFecha.CompareTo(Dominio.Fecha.getFechaActual()) > 0)
                    throw new Exception("La fecha del extremo inferior del intervalo de fechas no puede ser mayor a la fecha actual");
            }

            if (!textBox7.Text.Length.Equals(0))
            {
                DateTime extremoSuperiorIntervaloFecha = Convert.ToDateTime(textBox7.Text);
                if (extremoSuperiorIntervaloFecha.CompareTo(Dominio.Fecha.getFechaActual()) > 0)
                    throw new Exception("La fecha del extremo superior del intervalo de fechas no puede ser mayor a la fecha actual");
            }

            if ((!textBox6.Text.Length.Equals(0)) && (!textBox7.Text.Length.Equals(0)))
            {
                DateTime extremoInferiorIntervaloFecha = Convert.ToDateTime(textBox6.Text);
                DateTime extremoSuperiorIntervaloFecha = Convert.ToDateTime(textBox7.Text);

                if (extremoInferiorIntervaloFecha.CompareTo(extremoSuperiorIntervaloFecha) > 0)
                    throw new Exception("El extremo inferior del intervalo de fechas no puede ser mayor al extremo superior");
            }
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
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.facturasRealizadasAlVendedor(@fechaInicio, @fechaFinalizacion, @codigoPublicacion, @codigoFactura, @importeMinimo, @importeMaximo, @destinatario) ORDER BY Fecha,Código_Factura OFFSET ((@NUM_PAG - 1) * 10) ROWS FETCH NEXT 10 ROWS ONLY";
            consulta.Parameters.Add(new SqlParameter("@fechaInicio", this.filtrarFechaInicio()));
            consulta.Parameters.Add(new SqlParameter("@fechaFinalizacion", this.filtrarFechaFinalizacion()));
            consulta.Parameters.Add(new SqlParameter("@codigoPublicacion", this.filtrarCodigoPublicacion()));
            consulta.Parameters.Add(new SqlParameter("@codigoFactura", this.filtrarCodigoFactura()));
            consulta.Parameters.Add(new SqlParameter("@importeMinimo", this.filtrarImporteMinimo()));
            consulta.Parameters.Add(new SqlParameter("@importeMaximo", this.filtrarImporteMaximo()));
            consulta.Parameters.Add(new SqlParameter("@destinatario", this.filtrarDestinatario()));
            consulta.Parameters.Add(new SqlParameter("@NUM_PAG", paginaActual));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return reader;
        }

        private int getCantidadDeFacturas()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT GD1C2016.SALUDOS.cantidadDeFacturas(@fechaInicio, @fechaFinalizacion, @codigoPublicacion, @codigoFactura, @importeMinimo, @importeMaximo, @destinatario)";
            consulta.Parameters.Add(new SqlParameter("@fechaInicio", this.filtrarFechaInicio()));
            consulta.Parameters.Add(new SqlParameter("@fechaFinalizacion", this.filtrarFechaFinalizacion()));
            consulta.Parameters.Add(new SqlParameter("@codigoPublicacion", this.filtrarCodigoPublicacion()));
            consulta.Parameters.Add(new SqlParameter("@codigoFactura", this.filtrarCodigoFactura()));
            consulta.Parameters.Add(new SqlParameter("@importeMinimo", this.filtrarImporteMinimo()));
            consulta.Parameters.Add(new SqlParameter("@importeMaximo", this.filtrarImporteMaximo()));
            consulta.Parameters.Add(new SqlParameter("@destinatario", this.filtrarDestinatario()));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();
            reader.Read();

            return (int)reader.GetValue(0);
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
            try
            {
                this.validarCampos();
                this.paginaActual = 1;
                ConfiguradorDataGrid.llenarDataGridConConsulta(this.facturasRealizadasAlVendedor(), dataGridView1);
                textBox4.Text = this.paginaActual.ToString();
                int cantidadDeFacturas = dataGridView1.RowCount;
                int cantidadDePaginas = Convert.ToInt32(Convert.ToDouble(cantidadDeFacturas / 10));
                this.ultimaPagina = this.getCantidadDeFacturas();
                textBox5.Text = this.ultimaPagina.ToString();
            }
            catch (Exception excepcion)
            {
                MessageBox.Show(excepcion.Message, "Error", MessageBoxButtons.OK);
            }


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
                ConfiguradorDataGrid.llenarDataGridConConsulta(this.facturasRealizadasAlVendedor(), dataGridView1);
            }
        }

        private void retrocederPagina()
        {
            if (paginaActual > 1)
            {
                paginaActual = paginaActual - 1;
                textBox4.Text = paginaActual.ToString();
                ConfiguradorDataGrid.llenarDataGridConConsulta(this.facturasRealizadasAlVendedor(), dataGridView1);
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.retrocederPagina();
        }

        private void irAPrimeraPagina()
        {
            paginaActual = 1;
            textBox4.Text = paginaActual.ToString();
            ConfiguradorDataGrid.llenarDataGridConConsulta(this.facturasRealizadasAlVendedor(), dataGridView1);
        }

        private void irAUltimaPagina()
        {
            paginaActual = ultimaPagina;
            textBox4.Text = paginaActual.ToString();
            ConfiguradorDataGrid.llenarDataGridConConsulta(this.facturasRealizadasAlVendedor(), dataGridView1);
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
            if (dataGridView1.SelectedRows.Count > 0)
            {
                int codigoFactura = Convert.ToInt32(dataGridView1.SelectedRows[0].Cells[0].Value);
                int codigoPublicacion = Convert.ToInt32(dataGridView1.SelectedRows[0].Cells[1].Value);
                decimal total = Convert.ToDecimal(dataGridView1.SelectedRows[0].Cells[3].Value);
                DateTime fechaFacturacion = Convert.ToDateTime(dataGridView1.SelectedRows[0].Cells[4].Value);

                String destinatario;

                if (Usuario.getTipoUsuario(username).Equals("Administrador"))
                    destinatario = dataGridView1.SelectedRows[0].Cells[2].Value.ToString();
                else
                    destinatario = textBox3.Text;

                DetalleFactura detalleFactura = new DetalleFactura(codigoFactura, codigoPublicacion, destinatario, fechaFacturacion, total);
                detalleFactura.Show();
            }
        }

        private void button8_Click(object sender, EventArgs e)
        {
            this.verDetalleFactura();
        }
    }
}
