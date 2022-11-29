import matplotlib.pyplot as plt

from datetime import datetime

from data import RecordCollection


def plot_average_temperatures(collection: RecordCollection):
    tstart = datetime.now()
    print(f'Affichage des temperatures moyennes')
    print(f'(1) collecte des donnees')
    x_labels = []
    y_values = []
    for date in collection.dates:
        records = collection.get_records_by_date(date)
        temperatures = [rec.temperature for rec in records]
        temperatures = [t for t in temperatures if t is not None]
        mean_temp = sum(temperatures) / len(temperatures)
        x_labels.append(date)
        y_values.append(mean_temp)
    print(f'(2) affichage de {len(y_values)} temperatures')

    tend = datetime.now()
    tTotal = tend - tstart
    print("Temps ecoule pour la collecte de donnes : " + str(tTotal.total_seconds()))

    plt.plot(x_labels, y_values)
    plt.show()


def demo():
    collection = RecordCollection.from_month(10, 2022)
    plot_average_temperatures(collection)


if __name__ == '__main__':
    demo()
