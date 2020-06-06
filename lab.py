from madt_lib.network import Network, Overlay


def main():
    net = Network('15.0.0.0/8')
    node1 = net.create_node('Node0', image='madt/kind', entrypoint="sleep infinity", ports={'8008/tcp': 8008, '9080/tcp': 9080, '31870/tcp': 31870}, enable_internet=True, privileged=True)
    node2 = net.create_node('Node1', image='madt/kind', entrypoint="sleep infinity", ports={'8009/tcp': 8009}, enable_internet=True, privileged=True)
    net.create_subnet('net', (node1, node2))

    net.configure(verbose=True)
    net.render('../../labs/kind', verbose=True)

if __name__ == "__main__":
    main()
