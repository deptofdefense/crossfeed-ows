import React, { useCallback, useEffect, useMemo, useState } from 'react';
import { Link } from 'react-router-dom';
import {
  Paper,
  makeStyles,
  Accordion,
  AccordionSummary,
  Typography,
  AccordionDetails
} from '@material-ui/core';
import { Launch as LinkOffIcon } from '@material-ui/icons';
import { Domain } from 'types';
import { useDomainApi } from 'hooks';
import { DefinitionList } from './DefinitionList';
import { formatDistanceToNow, parseISO } from 'date-fns';

interface Props {
  domainId: string;
}

export const DomainDetails: React.FC<Props> = (props) => {
  const { domainId } = props;
  const { getDomain } = useDomainApi(false);
  const [domain, setDomain] = useState<Domain>();
  const classes = useStyles();

  const fetchDomain = useCallback(async () => {
    try {
      setDomain(undefined);
      const result = await getDomain(domainId);
      setDomain(result);
    } catch (e) {
      console.error(e);
    }
  }, [domainId, getDomain]);

  useEffect(() => {
    fetchDomain();
  }, [fetchDomain]);

  const webInfo = useMemo(() => {
    if (!domain) {
      return [];
    }
    const categoriesToProducts: Record<string, Set<string>> = {};
    for (const service of domain.services) {
      for (const product of service.products) {
        const version = product.version ? ` ${product.version}` : '';
        const value = product.name + version;
        const name = product?.tags[0] ?? 'Misc';
        if (!categoriesToProducts[name]) {
          categoriesToProducts[name] = new Set();
        }
        categoriesToProducts[name].add(value);
      }
    }
    return Object.entries(categoriesToProducts).reduce(
      (acc, [name, value]) => [
        ...acc,
        {
          label: name,
          value: Array.from(value)
        }
      ],
      [] as any
    );
  }, [domain]);

  const orgInfo = useMemo(() => {
    if (!domain) {
      return [];
    }
    return [
      {
        label: 'Organization',
        value: domain.organization.name
      },
      {
        label: 'Root Domains',
        value: domain.organization.rootDomains.join(', ')
      },
      {
        label: 'Passive Mode',
        value: domain.organization.isPassive ? 'Yes' : 'No'
      }
    ];
  }, [domain]);

  const overviewInfo = useMemo(() => {
    if (!domain) {
      return [];
    }
    const ret = [];
    if (domain.ip) {
      ret.push({
        label: 'IP',
        value: domain.ip
      });
    }
    ret.push({
      label: 'First Seen',
      value: `${formatDistanceToNow(parseISO(domain.createdAt))} ago`
    });
    ret.push({
      label: 'Last Seen',
      value: `${formatDistanceToNow(parseISO(domain.updatedAt))} ago`
    });
    if (domain.country) {
      ret.push({
        label: 'Country',
        value: domain.country
      });
    }
    if (domain.cloudHosted) {
      ret.push({
        label: 'Cloud Hosted',
        value: 'Yes'
      });
    }
    return ret;
  }, [domain]);

  if (!domain) {
    return null;
  }

  return (
    <Paper classes={{ root: classes.root }}>
      <Link to={`/domain/${domain.id}`} className={classes.title}>
        <h4>{domain.name}</h4>
        <LinkOffIcon />
      </Link>
      <div className={classes.inner}>
        <div className={classes.section}>
          <h4 className={classes.subtitle}>Organization</h4>
          <DefinitionList items={orgInfo} />
        </div>
        {overviewInfo.length > 0 && (
          <div className={classes.section}>
            <h4 className={classes.subtitle}>Overview</h4>
            <DefinitionList items={overviewInfo} />
          </div>
        )}
        {webInfo.length > 0 && (
          <div className={classes.section}>
            <h4 className={classes.subtitle}>Known Products</h4>
            <DefinitionList items={webInfo} />
          </div>
        )}
        {domain.services.length > 0 && (
          <div className={classes.section}>
            <h4 className={classes.subtitle}>Ports</h4>
            {domain.services.map((service) => (
              <Accordion className={classes.accordion} key={service.id}>
                <AccordionSummary>
                  <Typography className={classes.accordionHeading}>
                    {service.port}
                  </Typography>
                  {service.lastSeen && (
                    <Typography>
                      {formatDistanceToNow(parseISO(service.lastSeen))} ago
                    </Typography>
                  )}
                </AccordionSummary>
                {service.products.length > 0 && (
                  <AccordionDetails>
                    <DefinitionList
                      items={service.products.reduce(
                        (acc, product) => [
                          ...acc,
                          {
                            label: product.cpe ?? 'Misc',
                            value:
                              product.name +
                              (product.version ? ` ${product.version}` : '')
                          }
                        ],
                        [] as any
                      )}
                    />
                  </AccordionDetails>
                )}
              </Accordion>
            ))}
          </div>
        )}
        {domain.vulnerabilities.length > 0 && (
          <div className={classes.section}>
            <h4 className={classes.subtitle}>Vulnerabilities</h4>
            {domain.vulnerabilities.map((vuln) => (
              <Accordion className={classes.accordion} key={vuln.id}>
                <AccordionSummary>
                  <Typography className={classes.accordionHeading}>
                    {vuln.cve}
                  </Typography>
                  <Typography className={classes.vulnDescription}>
                    {vuln.state}
                  </Typography>
                  <Typography className={classes.vulnDescription}>
                    {vuln.severity}
                  </Typography>
                  <Typography className={classes.vulnDescription}>
                    {vuln.lastSeen
                      ? `${formatDistanceToNow(parseISO(vuln.lastSeen))} ago`
                      : ''}
                  </Typography>
                </AccordionSummary>
                <AccordionDetails>
                  <DefinitionList
                    items={[
                      {
                        label: 'CVE',
                        value: vuln.cve ?? 'N/A'
                      },
                      {
                        label: 'Severity',
                        value: vuln.severity ?? 'N/A'
                      },
                      {
                        label: 'CVSS',
                        value: vuln.cvss?.toString() ?? 'N/A'
                      },
                      {
                        label: 'CPE',
                        value: vuln.cpe ?? 'N/A'
                      },
                      {
                        label: 'State',
                        value: vuln.state ?? 'N/A'
                      }
                    ]}
                  />
                </AccordionDetails>
              </Accordion>
            ))}
          </div>
        )}
        {/* <pre>{JSON.stringify(domain, undefined, '  ')}</pre> */}
      </div>
    </Paper>
  );
};

const useStyles = makeStyles((theme) => ({
  root: {
    border: `2px solid ${theme.palette.primary.main}`,
    marginBottom: '1rem',
    '& *:focus': {
      outline: 'none !important'
    }
  },
  title: {
    backgroundColor: theme.palette.primary.main,
    color: '#fff',
    cursor: 'pointer',
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: '1rem 1.5rem',
    fontSize: '2rem',
    textDecoration: 'none',

    '& > h4': {
      wordBreak: 'break-all',
      paddingRight: '2rem',
      margin: '0'
    }
  },
  section: {
    marginBottom: '1.5rem'
  },
  subtitle: {
    margin: 0,
    padding: '0 0 0.2rem 0',
    fontSize: '1.2rem',
    fontWeight: 500,
    color: '#3D4551'
  },
  inner: {
    padding: '1.5rem'
  },
  accordion: {
    color: '#3D4551'
  },
  accordionHeading: {
    flex: '1 0 33%'
  },
  vulnDescription: {
    flex: '1 1 15%',
    textOverflow: 'hidden',
    textAlign: 'right'
  }
}));
